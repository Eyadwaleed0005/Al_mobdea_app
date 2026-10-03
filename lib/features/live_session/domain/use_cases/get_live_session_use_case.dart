import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/live_session/domain/entity/live_session_entity.dart';
import 'package:al_mobdea/features/live_session/domain/repositories/live_session_repository.dart';
import 'package:dartz/dartz.dart';

class GetLiveSessionUseCase {
  const GetLiveSessionUseCase({required this.repository});

  final LiveSessionRepository repository;

  Future<Either<AppErrorModel, LiveSessionEntity>> getLiveSession({
    required String gradeId,
  }) {
    return repository.getLiveSession(gradeId: gradeId);
  }

  Future<Either<AppErrorModel, LiveSessionEntity>> call({
    required String gradeId,
  }) {
    return getLiveSession(gradeId: gradeId);
  }
}
