import 'package:al_mobdea/core/errors/handlers/firebase_auth_error_handler.dart';
import 'package:al_mobdea/core/errors/handlers/firebase_error_handler.dart';
import 'package:al_mobdea/core/firebase/firestore/firestore_collections.dart';
import 'package:al_mobdea/core/firebase/firestore/firestore_service.dart';
import 'package:al_mobdea/features/profile/data/data_source/my_subscription_remote_data_source.dart';
import 'package:al_mobdea/features/profile/data/models/my_subscription_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseMySubscriptionRemoteDataSource
    implements MySubscriptionRemoteDataSource {
  const FirebaseMySubscriptionRemoteDataSource({
    required FirebaseAuth firebaseAuth,
    required FirestoreService firestoreService,
  }) : _firebaseAuth = firebaseAuth,
       _firestoreService = firestoreService;

  final FirebaseAuth _firebaseAuth;
  final FirestoreService _firestoreService;

  @override
  Stream<MySubscriptionModel> streamMySubscription() {
    return FirebaseErrorHandler.executeStream(() {
      final user = _firebaseAuth.currentUser;

      if (user == null) {
        FirebaseErrorHandler.throwAuthCode(
          FirebaseAuthErrorHandler.authenticatedUserNotFoundCode,
        );
      }

      return _firestoreService
          .streamDocument(
            collectionPath: FirestoreCollections.students,
            documentId: user.uid,
          )
          .map((snapshot) {
            final data = snapshot.data();

            if (!snapshot.exists || data == null) {
              FirebaseErrorHandler.throwFirestoreCode('not-found');
            }

            try {
              return MySubscriptionModel.fromFirestore(data);
            } on FormatException {
              FirebaseErrorHandler.throwFirestoreCode('data-loss');
            } on TypeError {
              FirebaseErrorHandler.throwFirestoreCode('data-loss');
            }
          });
    });
  }
}
