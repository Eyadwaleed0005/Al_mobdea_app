import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/lesson_quiz/domain/entity/lesson_quiz_entity.dart';
import 'package:al_mobdea/features/lesson_quiz/domain/repositories/lesson_quiz_repo.dart';
import 'package:dartz/dartz.dart';

class GetLessonQuizUseCase {
  final LessonQuizRepository repository;

  const GetLessonQuizUseCase({
    required this.repository,
  });

  Future<Either<AppErrorModel, LessonQuizEntity>> call({
    required String lessonId,
  }) {
    return repository.getLessonQuiz(
      lessonId: lessonId,
    );
  }
}
