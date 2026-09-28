import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/study_notes/domain/entities/study_note_entity.dart';
import 'package:dartz/dartz.dart';

abstract class StudyNotesRepository {
  Future<Either<AppErrorModel, StudyNoteEntity>> getStudyNoteById({
    required String noteId,
  });

  Stream<Either<AppErrorModel, List<StudyNoteEntity>>> streamStudyNotes();
}
