import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/app_startup/domain/repositories/app_startup_repository.dart';
import 'package:al_mobdea/features/lessons/domain/entities/lesson_entity.dart';
import 'package:dartz/dartz.dart';

class CheckLessonAccessUseCase {
  const CheckLessonAccessUseCase({required AppStartupRepository repository})
    : _repository = repository;

  final AppStartupRepository _repository;

  Future<Either<AppErrorModel, bool>> call({
    required LessonEntity lesson,
  }) async {
    if (lesson.isFree) {
      return const Right(true);
    }

    return checkSubscription();
  }

  Future<Either<AppErrorModel, bool>> checkSubscription() async {
    final studentId = _repository.getCurrentUserId();

    if (studentId == null || studentId.trim().isEmpty) {
      return const Right(false);
    }

    final result = await _repository.getStudentAccess(
      studentId: studentId.trim(),
    );

    return result.map((studentAccess) => studentAccess.isActive);
  }
}
