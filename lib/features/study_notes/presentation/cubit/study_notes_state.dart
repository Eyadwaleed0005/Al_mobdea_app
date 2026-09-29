import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/study_notes/domain/entities/study_note_entity.dart';

sealed class StudyNotesState {
  const StudyNotesState();
}

final class StudyNotesInitial extends StudyNotesState {
  const StudyNotesInitial();
}

final class StudyNotesLoading extends StudyNotesState {
  const StudyNotesLoading();
}

final class StudyNotesEmpty extends StudyNotesState {
  const StudyNotesEmpty();
}

final class StudyNotesSuccess extends StudyNotesState {
  const StudyNotesSuccess({required this.notes});

  final List<StudyNoteEntity> notes;
}

final class StudyNotesFailure extends StudyNotesState {
  const StudyNotesFailure({required this.error});

  final AppErrorModel error;
}
