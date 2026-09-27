import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/live_session/domain/entity/live_session_entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class LiveSessionRepository {
  Future<Either<AppErrorModel, LiveSessionEntity>> getLiveSession({
    required String gradeId,
  });
}
