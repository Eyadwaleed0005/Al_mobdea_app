import 'package:al_mobdea/core/errors/handlers/firebase_error_handler.dart';
import 'package:al_mobdea/core/firebase/firestore/firestore_collections.dart';
import 'package:al_mobdea/core/firebase/firestore/firestore_fields.dart';
import 'package:al_mobdea/core/firebase/firestore/firestore_service.dart';
import 'package:al_mobdea/features/authentication/data/data_source/remote/logout_remote_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseLogoutRemoteDataSource implements LogoutRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirestoreService firestoreService;

  const FirebaseLogoutRemoteDataSource({
    required this.firebaseAuth,
    required this.firestoreService,
  });

  @override
  Future<void> logout() {
    return FirebaseErrorHandler.execute<void>(() async {
      final currentUser = firebaseAuth.currentUser;

      if (currentUser == null) {
        return;
      }

      await firestoreService.patchData(
        collectionPath: FirestoreCollections.students,
        documentId: currentUser.uid,
        data: {FirestoreFields.isLoggedIn: false},
      );

      await firebaseAuth.signOut();
    });
  }
}
