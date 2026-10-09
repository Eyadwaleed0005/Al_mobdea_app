import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/lessons/domain/entities/lesson_entity.dart';
import 'package:al_mobdea/features/lessons/domain/entities/lesson_pdf_entity.dart';
import 'package:al_mobdea/features/lessons/domain/repositories/lesson_pdf_repository.dart';
import 'package:dartz/dartz.dart';

class GetLessonPdfUseCase {
  final LessonPdfRepository _repository;

  const GetLessonPdfUseCase({required LessonPdfRepository repository})
    : _repository = repository;

  Future<Either<AppErrorModel, LessonPdfEntity>> call({
    required LessonEntity lesson,
  }) {
    return _repository.getLessonPdf(lesson: lesson);
  }
}
