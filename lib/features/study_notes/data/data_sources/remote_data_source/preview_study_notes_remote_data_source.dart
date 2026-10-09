import 'package:al_mobdea/features/study_notes/data/data_sources/remote_data_source/study_notes_remote_data_source.dart';
import 'package:al_mobdea/features/study_notes/data/models/study_note_model.dart';

//! TODO: remove this file when firebase is initialized and start using [FirebaseStudyNotesRemoteDataSource]
class PreviewStudyNotesRemoteDataSource implements StudyNotesRemoteDataSource {
  const PreviewStudyNotesRemoteDataSource();

  static const List<StudyNoteModel> _notes = [
    StudyNoteModel(
      noteId: 'preview-mubtada-khabar-note',
      name: 'ملزمة المبتدأ والخبر',
      description: 'المبتدأ والخبر · ملف PDF',
      gradeId: 'preview-grade',
      isPublished: true,
      pdfStoragePath: 'preview/notes/mubtada-khabar.pdf',
      pdfFileName: 'ملزمة المبتدأ والخبر.pdf',
      pdfFileSize: 0,
    ),
    StudyNoteModel(
      noteId: 'preview-arabic-nahw-note',
      name: 'ذرائط النحو العربي',
      description: 'الجملة الاسمية · ملف PDF',
      gradeId: 'preview-grade',
      isPublished: true,
      pdfStoragePath: 'preview/notes/arabic-nahw.pdf',
      pdfFileName: 'ذرائط النحو العربي.pdf',
      pdfFileSize: 0,
    ),
  ];

  @override
  Future<StudyNoteModel> getStudyNoteById({
    required String noteId,
    required String gradeId,
  }) async => _notes.firstWhere((note) => note.noteId == noteId);

  @override
  Stream<List<StudyNoteModel>> streamStudyNotes({required String gradeId}) => Stream.value(_notes);
}
