import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/study_notes/domain/entities/study_note_entity.dart';
import 'package:al_mobdea/features/study_notes/domain/use_case/stream_study_notes_use_case.dart';
import 'package:al_mobdea/features/study_notes/presentation/cubit/study_notes_cubit.dart';
import 'package:al_mobdea/features/study_notes/presentation/cubit/study_notes_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStreamStudyNotesUseCase extends Mock
    implements StreamStudyNotesUseCase {}

void main() {
  late MockStreamStudyNotesUseCase mockStreamStudyNotesUseCase;

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
    mockStreamStudyNotesUseCase = MockStreamStudyNotesUseCase();
    registerFallbackValue(
      const Left<AppErrorModel, List<StudyNoteEntity>>(tAppError),
    );
  });

  group('StudyNotesCubit', () {
    blocTest<StudyNotesCubit, StudyNotesState>(
      'emits [StudyNotesLoading, StudyNotesSuccess] when notes are loaded',
      build: () {
        when(
          () => mockStreamStudyNotesUseCase(),
        ).thenAnswer((_) => Stream.value(const Right(tNotes)));
        return StudyNotesCubit(
          streamStudyNotesUseCase: mockStreamStudyNotesUseCase,
        );
      },
      act: (cubit) => cubit.initialize(),
      expect:
          () => <Matcher>[
            isA<StudyNotesLoading>(),
            isA<StudyNotesSuccess>().having(
              (state) => state.notes.length,
              'notes.length',
              tNotes.length,
            ),
          ],
    );

    blocTest<StudyNotesCubit, StudyNotesState>(
      'emits [StudyNotesLoading, StudyNotesEmpty] when empty',
      build: () {
        when(
          () => mockStreamStudyNotesUseCase(),
        ).thenAnswer((_) => Stream.value(const Right(<StudyNoteEntity>[])));
        return StudyNotesCubit(
          streamStudyNotesUseCase: mockStreamStudyNotesUseCase,
        );
      },
      act: (cubit) => cubit.initialize(),
      expect:
          () => <Matcher>[isA<StudyNotesLoading>(), isA<StudyNotesEmpty>()],
    );

    blocTest<StudyNotesCubit, StudyNotesState>(
      'emits [StudyNotesLoading, StudyNotesFailure] on error',
      build: () {
        when(
          () => mockStreamStudyNotesUseCase(),
        ).thenAnswer((_) => Stream.value(const Left(tAppError)));
        return StudyNotesCubit(
          streamStudyNotesUseCase: mockStreamStudyNotesUseCase,
        );
      },
      act: (cubit) => cubit.initialize(),
      expect:
          () => <Matcher>[
            isA<StudyNotesLoading>(),
            isA<StudyNotesFailure>().having(
              (state) => state.error.code,
              'error.code',
              tAppError.code,
            ),
          ],
    );
  });
}
