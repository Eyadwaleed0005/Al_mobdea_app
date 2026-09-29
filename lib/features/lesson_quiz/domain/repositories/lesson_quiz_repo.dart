import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/lesson_quiz/domain/entity/lesson_quiz_entity.dart';
import 'package:dartz/dartz.dart';

abstract class LessonQuizRepository {
  Future<Either<AppErrorModel, LessonQuizEntity>> getLessonQuiz({
    required String lessonId,
  });
}
