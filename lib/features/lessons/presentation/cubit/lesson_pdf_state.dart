import 'dart:typed_data';

import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/lessons/domain/entities/lesson_pdf_entity.dart';

sealed class LessonPdfState {
  const LessonPdfState();
}

final class LessonPdfInitial extends LessonPdfState {
  const LessonPdfInitial();
}

final class LessonPdfLoading extends LessonPdfState {
  const LessonPdfLoading();
}

final class LessonPdfSuccess extends LessonPdfState {
  const LessonPdfSuccess({required this.pdfBytes, required this.source});

  final Uint8List pdfBytes;
  final LessonPdfSource source;
}

final class LessonPdfFailure extends LessonPdfState {
  const LessonPdfFailure({required this.error});

  final AppErrorModel error;
}

final class LessonPdfEmpty extends LessonPdfState {
  const LessonPdfEmpty();
}
