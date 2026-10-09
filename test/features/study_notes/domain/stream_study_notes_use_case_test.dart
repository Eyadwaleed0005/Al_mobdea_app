import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/study_notes/domain/entities/study_note_entity.dart';
import 'package:al_mobdea/features/study_notes/domain/repositories/study_notes_repository.dart';
import 'package:al_mobdea/features/study_notes/domain/use_case/stream_study_notes_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStudyNotesRepository extends Mock implements StudyNotesRepository {}

void main() {
  late MockStudyNotesRepository mockStudyNotesRepository;
  late StreamStudyNotesUseCase streamStudyNotesUseCase;

  const tNotes = <StudyNoteEntity>[
    StudyNoteEntity(
      noteId: 'note-1',
      name: 'ملزمة الرياضيات',
      description: 'ملخص الدرس الأول',
      gradeId: 'grade-1',
      isPublished: true,
      pdfStoragePath: 'notes/note-1.pdf',
      pdfFileName: 'note-1.pdf',
      pdfFileSize: 1024,
    ),
    StudyNoteEntity(
      noteId: 'note-2',
      name: 'ملزمة الفيزياء',
      description: 'ملخص الدرس الثاني',
      gradeId: 'grade-1',
      isPublished: true,
      pdfStoragePath: 'notes/note-2.pdf',
      pdfFileName: 'note-2.pdf',
      pdfFileSize: 2048,
    ),
  ];

  const tAppError = AppErrorModel(
    code: 'firestore-error',
    message: 'تعذر تحميل الملزمات',
    type: AppErrorType.unknown,
    isRetryable: true,
  );

  setUp(() {
    mockStudyNotesRepository = MockStudyNotesRepository();
    streamStudyNotesUseCase = StreamStudyNotesUseCase(
      repository: mockStudyNotesRepository,
    );
  });

  group('StreamStudyNotesUseCase', () {
    test(
      'should return stream of Right(notes) when repository call succeeds',
      () async {
        // arrange
        when(
          () => mockStudyNotesRepository.streamStudyNotes(),
        ).thenAnswer((_) => Stream.value(const Right(tNotes)));

        // act
        final result = await streamStudyNotesUseCase().first;

        // assert
        expect(result, const Right(tNotes));
        verify(() => mockStudyNotesRepository.streamStudyNotes()).called(1);
        verifyNoMoreInteractions(mockStudyNotesRepository);
      },
    );

    test(
      'should return AppErrorModel when repository fails',
      () async {
        // arrange
        when(
          () => mockStudyNotesRepository.streamStudyNotes(),
        ).thenAnswer((_) => Stream.value(const Left(tAppError)));

        // act
        final result = await streamStudyNotesUseCase().first;

        // assert
        expect(result, const Left(tAppError));
        verify(() => mockStudyNotesRepository.streamStudyNotes()).called(1);
        verifyNoMoreInteractions(mockStudyNotesRepository);
      },
    );
  });
}
