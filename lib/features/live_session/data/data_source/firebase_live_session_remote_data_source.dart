import 'package:al_mobdea/core/firebase/firestore/firestore_collections.dart';
import 'package:al_mobdea/core/firebase/firestore/firestore_service.dart';
import 'package:al_mobdea/features/live_session/data/data_source/live_session_remote_data_source.dart';
import 'package:al_mobdea/features/live_session/data/models/live_session_model.dart';

class FirebaseLiveSessionRemoteDataSource
    implements LiveSessionRemoteDataSource {
  const FirebaseLiveSessionRemoteDataSource({required this.firestoreService});

  final FirestoreService firestoreService;

  @override
  Future<LiveSessionModel> getLiveSession({required String gradeId}) async {
    final document = await firestoreService.getDocument(
      collectionPath: FirestoreCollections.liveSessions,
      documentId: gradeId,
    );

    return LiveSessionModel.fromFirestore(document);
  }
}
