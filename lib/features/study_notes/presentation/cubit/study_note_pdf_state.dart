import 'dart:typed_data';

import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';

sealed class StudyNotePdfState {
  const StudyNotePdfState();
}

final class StudyNotePdfInitial extends StudyNotePdfState {
  const StudyNotePdfInitial();
}

final class StudyNotePdfLoading extends StudyNotePdfState {
  const StudyNotePdfLoading();
}

final class StudyNotePdfReady extends StudyNotePdfState {
  const StudyNotePdfReady({required this.pdfBytes});

  final Uint8List pdfBytes;
}

final class StudyNotePdfError extends StudyNotePdfState {
  const StudyNotePdfError({required this.error});

  final AppErrorModel error;
}
