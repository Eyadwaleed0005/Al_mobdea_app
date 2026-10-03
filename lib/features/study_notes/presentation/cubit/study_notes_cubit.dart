import 'dart:async';

import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/study_notes/domain/entities/study_note_entity.dart';
import 'package:al_mobdea/features/study_notes/domain/use_case/stream_study_notes_use_case.dart';
import 'package:al_mobdea/features/study_notes/presentation/cubit/study_notes_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudyNotesCubit extends Cubit<StudyNotesState> {
  StudyNotesCubit({required StreamStudyNotesUseCase streamStudyNotesUseCase})
    : _streamStudyNotesUseCase = streamStudyNotesUseCase,
      super(const StudyNotesInitial());

  final StreamStudyNotesUseCase _streamStudyNotesUseCase;
  StreamSubscription<Either<AppErrorModel, List<StudyNoteEntity>>>?
  _notesSubscription;
  bool _isInitializing = false;
  bool _isClosing = false;

  bool get _canEmit => !_isClosing && !isClosed;

  Future<void> initialize() async {
    if (_isInitializing || !_canEmit) return;
    _isInitializing = true;
    try {
      await _cancelSubscription();
      if (!_canEmit) return;
      emit(const StudyNotesLoading());
      _notesSubscription = _streamStudyNotesUseCase().listen(_onNotesResult);
    } finally {
      _isInitializing = false;
    }
  }

  Future<void> retry() => initialize();

  void _onNotesResult(Either<AppErrorModel, List<StudyNoteEntity>> result) {
    if (!_canEmit) return;
    result.fold((error) => emit(StudyNotesFailure(error: error)), (notes) {
      if (notes.isEmpty) {
        emit(const StudyNotesEmpty());
      } else {
        emit(
          StudyNotesSuccess(notes: List<StudyNoteEntity>.unmodifiable(notes)),
        );
      }
    });
  }

  Future<void> _cancelSubscription() async {
    final subscription = _notesSubscription;
    _notesSubscription = null;
    await subscription?.cancel();
  }

  @override
  Future<void> close() async {
    if (_isClosing || isClosed) return;
    _isClosing = true;
    await _cancelSubscription();
    await super.close();
  }
}
