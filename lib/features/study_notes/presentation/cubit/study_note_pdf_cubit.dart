import 'package:al_mobdea/core/errors/handlers/firebase_error_handler.dart';
import 'package:al_mobdea/features/study_notes/domain/entities/study_note_entity.dart';
import 'package:al_mobdea/features/study_notes/domain/use_case/get_study_note_pdf_use_case.dart';
import 'package:al_mobdea/features/study_notes/presentation/cubit/study_note_pdf_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudyNotePdfCubit extends Cubit<StudyNotePdfState> {
  StudyNotePdfCubit({required GetStudyNotePdfUseCase getStudyNotePdfUseCase})
    : _getStudyNotePdfUseCase = getStudyNotePdfUseCase,
      super(const StudyNotePdfInitial());

  final GetStudyNotePdfUseCase _getStudyNotePdfUseCase;
  bool _isLoading = false;
  bool _isClosing = false;

  bool get _canEmit => !_isClosing && !isClosed;

  Future<void> loadPdf({required StudyNoteEntity note}) async {
    if (_isLoading || !_canEmit) return;
    if (note.pdfStoragePath.trim().isEmpty) {
      emit(
        StudyNotePdfError(
          error: FirebaseErrorHandler.handleStorageCode('object-not-found'),
        ),
      );
      return;
    }

    _isLoading = true;
    try {
      emit(const StudyNotePdfLoading());
      final result = await _getStudyNotePdfUseCase(note: note);
      if (!_canEmit) return;
      result.fold((error) => emit(StudyNotePdfError(error: error)), (pdf) {
        if (pdf.bytes.isEmpty) {
          emit(
            StudyNotePdfError(
              error: FirebaseErrorHandler.handleStorageCode('object-not-found'),
            ),
          );
        } else {
          emit(StudyNotePdfReady(pdfBytes: pdf.bytes));
        }
      });
    } finally {
      _isLoading = false;
    }
  }

  Future<void> retry({required StudyNoteEntity note}) => loadPdf(note: note);

  @override
  Future<void> close() async {
    if (_isClosing || isClosed) return;
    _isClosing = true;
    await super.close();
  }
}
