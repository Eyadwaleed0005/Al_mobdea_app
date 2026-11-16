import 'package:al_mobdea/core/errors/handlers/firebase_auth_error_handler.dart';
import 'package:al_mobdea/core/errors/handlers/firebase_error_handler.dart';
import 'package:al_mobdea/core/firebase/firestore/firestore_collections.dart';
import 'package:al_mobdea/core/firebase/firestore/firestore_fields.dart';
import 'package:al_mobdea/core/firebase/firestore/firestore_service.dart';
import 'package:al_mobdea/features/profile/data/data_source/personal_info_remote_data_source.dart';
import 'package:al_mobdea/features/profile/data/models/personal_info_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebasePersonalInfoRemoteDataSource
    implements PersonalInfoRemoteDataSource {
  const FirebasePersonalInfoRemoteDataSource({
    required FirebaseAuth firebaseAuth,
    required FirestoreService firestoreService,
    required FirebaseFunctions firebaseFunctions,
  }) : _firebaseAuth = firebaseAuth,
       _firestoreService = firestoreService,
       _firebaseFunctions = firebaseFunctions;

  final FirebaseAuth _firebaseAuth;
  final FirestoreService _firestoreService;
  final FirebaseFunctions _firebaseFunctions;

  @override
  Future<PersonalInfoModel> getPersonalInfo() {
    return FirebaseErrorHandler.execute(() async {
      final user = _getAuthenticatedUser();

      final snapshot = await _firestoreService.getDocument(
        collectionPath: FirestoreCollections.students,
        documentId: user.uid,
      );

      final data = snapshot.data();

      if (!snapshot.exists || data == null) {
        FirebaseErrorHandler.throwFirestoreCode('not-found');
      }

      try {
        return PersonalInfoModel.fromFirestore(studentId: user.uid, data: data);
      } on FormatException {
        FirebaseErrorHandler.throwFirestoreCode('data-loss');
      }
    });
  }

  @override
  Future<void> updatePersonalInfo({
    required String name,
    required String phoneNumber,
    required String email,
    required String currentPassword,
  }) {
    return FirebaseErrorHandler.execute<void>(() async {
      final user = _getAuthenticatedUser();
      final currentEmail = _getRequiredEmail(user);

      await _reauthenticate(
        user: user,
        email: currentEmail,
        currentPassword: currentPassword,
      );

      final authenticatedUser = _getAuthenticatedUser();

      if (authenticatedUser.uid != user.uid) {
        FirebaseErrorHandler.throwAuthCode(
          FirebaseAuthErrorHandler.authenticatedUserNotFoundCode,
        );
      }

      final normalizedEmail = email.trim().toLowerCase();
      final emailChanged = normalizedEmail != currentEmail.trim().toLowerCase();

      if (emailChanged) {
        await _updateEmail(
          user: authenticatedUser,
          newEmail: normalizedEmail,
          currentPassword: currentPassword,
        );
      }

      final currentUser = _getAuthenticatedUser();

      if (currentUser.uid != user.uid) {
        FirebaseErrorHandler.throwAuthCode(
          FirebaseAuthErrorHandler.authenticatedUserNotFoundCode,
        );
      }

      await _firestoreService.patchData(
        collectionPath: FirestoreCollections.students,
        documentId: user.uid,
        data: {
          FirestoreFields.name: name.trim(),
          FirestoreFields.phoneNumber: phoneNumber.trim(),
          FirestoreFields.updatedAt: FieldValue.serverTimestamp(),
        },
      );
    });
  }

  User _getAuthenticatedUser() {
    final user = _firebaseAuth.currentUser;

    if (user == null) {
      FirebaseErrorHandler.throwAuthCode(
        FirebaseAuthErrorHandler.authenticatedUserNotFoundCode,
      );
    }

    return user;
  }

  String _getRequiredEmail(User user) {
    final email = user.email;

    if (email == null || email.trim().isEmpty) {
      FirebaseErrorHandler.throwAuthCode(
        FirebaseAuthErrorHandler.authenticatedUserNotFoundCode,
      );
    }

    return email;
  }

  Future<void> _reauthenticate({
    required User user,
    required String email,
    required String currentPassword,
  }) async {
    if (currentPassword.isEmpty) {
      FirebaseErrorHandler.throwAuthCode(
        FirebaseAuthErrorHandler.currentPasswordIncorrectCode,
      );
    }

    final credential = EmailAuthProvider.credential(
      email: email,
      password: currentPassword,
    );

    try {
      final result = await user.reauthenticateWithCredential(credential);

      if (result.user?.uid != user.uid) {
        FirebaseErrorHandler.throwAuthCode(
          FirebaseAuthErrorHandler.authenticatedUserNotFoundCode,
        );
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == 'wrong-password' ||
          error.code == 'invalid-credential' ||
          error.code == 'invalid-login-credentials') {
        FirebaseErrorHandler.throwAuthCode(
          FirebaseAuthErrorHandler.currentPasswordIncorrectCode,
        );
      }

      rethrow;
    }
  }

  Future<void> _updateEmail({
    required User user,
    required String newEmail,
    required String currentPassword,
  }) async {
    await user.getIdToken(true);

    final callable = _firebaseFunctions.httpsCallable('updateMyEmail');

    final result = await callable.call<Map<String, dynamic>>({
      'newEmail': newEmail,
    });

    if (result.data['success'] != true) {
      FirebaseErrorHandler.throwFunctionsCode('invalid-response');
    }

    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: newEmail,
      password: currentPassword,
    );

    if (credential.user?.uid != user.uid) {
      FirebaseErrorHandler.throwAuthCode(
        FirebaseAuthErrorHandler.authenticatedUserNotFoundCode,
      );
    }
  }
}
