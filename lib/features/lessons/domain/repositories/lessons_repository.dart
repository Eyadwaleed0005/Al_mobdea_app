import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/lessons/domain/entities/lesson_entity.dart';
import 'package:dartz/dartz.dart';

abstract class LessonsRepository {
  Future<Either<AppErrorModel, LessonEntity>> getLessonById({
    required String lessonId,
  });

  Stream<Either<AppErrorModel, List<LessonEntity>>> streamLessons();
}
