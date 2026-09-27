import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/core/errors/exceptions/firebase_remote_exception.dart';
import 'package:al_mobdea/core/errors/handlers/firebase_error_handler.dart';
import 'package:al_mobdea/features/live_session/data/data_source/live_session_remote_data_source.dart';
import 'package:al_mobdea/features/live_session/domain/entity/live_session_entity.dart';
import 'package:al_mobdea/features/live_session/domain/repositories/live_session_repository.dart';
import 'package:dartz/dartz.dart';

class LiveSessionRepositoryImpl implements LiveSessionRepository {
  const LiveSessionRepositoryImpl({required this.remoteDataSource});

  final LiveSessionRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppErrorModel, LiveSessionEntity>> getLiveSession({
    required String gradeId,
  }) async {
    try {
      final session = await remoteDataSource.getLiveSession(gradeId: gradeId);
      return right(session);
    } on FirebaseRemoteException catch (error) {
      return left(error.errorModel);
    } catch (error) {
      return left(FirebaseErrorHandler.handle(error));
    }
  }
}
