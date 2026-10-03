import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/lessons/domain/entities/lesson_entity.dart';
import 'package:al_mobdea/features/lessons/domain/repositories/lessons_repository.dart';
import 'package:dartz/dartz.dart';

class GetLessonByIdUseCase {
  final LessonsRepository _repository;

  const GetLessonByIdUseCase({required LessonsRepository repository})
    : _repository = repository;

  Future<Either<AppErrorModel, LessonEntity>> call({required String lessonId}) {
    return _repository.getLessonById(lessonId: lessonId);
  }
}
