import 'package:al_mobdea/features/live_session/data/models/live_session_model.dart';

abstract interface class LiveSessionRemoteDataSource {
  Future<LiveSessionModel> getLiveSession({required String gradeId});
}
