import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/lessons/domain/entities/lesson_entity.dart';
import 'package:al_mobdea/features/lessons/domain/use_cases/stream_lessons_use_case.dart';
import 'package:al_mobdea/features/lessons/presentation/cubit/lessons_cubit.dart';
import 'package:al_mobdea/features/lessons/presentation/cubit/lessons_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStreamLessonsUseCase extends Mock implements StreamLessonsUseCase {}

void main() {
  late MockStreamLessonsUseCase mockStreamLessonsUseCase;

  const tLessons = <LessonEntity>[
    LessonEntity(
      lessonId: 'lesson-1',
      title: 'الدرس الأول',
      description: 'شرح الدرس الأول',
      gradeId: 'grade-1',
      isPublished: true,
      youtubeUrl: 'https://youtube.com/watch?v=lesson-1',
      pdfStoragePath: 'lessons/lesson-1.pdf',
      pdfFileName: 'lesson-1.pdf',
      pdfFileSize: 1024,
    ),
    LessonEntity(
      lessonId: 'lesson-2',
      title: 'الدرس الثاني',
      description: 'شرح الدرس الثاني',
      gradeId: 'grade-1',
      isPublished: true,
      youtubeUrl: '',
      pdfStoragePath: 'lessons/lesson-2.pdf',
      pdfFileName: 'lesson-2.pdf',
      pdfFileSize: 2048,
    ),
  ];

  const tAppError = AppErrorModel(
    code: 'firestore-error',
    message: 'تعذر تحميل الدروس',
    type: AppErrorType.unknown,
    isRetryable: true,
  );

  setUp(() {
    mockStreamLessonsUseCase = MockStreamLessonsUseCase();
    registerFallbackValue(
      const Left<AppErrorModel, List<LessonEntity>>(tAppError),
    );
  });

  group('LessonsCubit', () {
    blocTest<LessonsCubit, LessonsState>(
      'emits [LessonsLoading, LessonsDataSuccess] when lessons are fetched',
      build: () {
        when(
          () => mockStreamLessonsUseCase(),
        ).thenAnswer((_) => Stream.value(const Right(tLessons)));
        return LessonsCubit(streamLessonsUseCase: mockStreamLessonsUseCase);
      },
      act: (cubit) => cubit.initialize(),
      expect:
          () => <Matcher>[
            isA<LessonsLoading>(),
            isA<LessonsDataSuccess>()
                .having(
                  (state) => state.lessons.length,
                  'lessons.length',
                  tLessons.length,
                )
                .having((state) => state.query, 'query', ''),
          ],
    );

    blocTest<LessonsCubit, LessonsState>(
      'emits [LessonsLoading, LessonsEmpty] when lessons list is empty',
      build: () {
        when(
          () => mockStreamLessonsUseCase(),
        ).thenAnswer((_) => Stream.value(const Right(<LessonEntity>[])));
        return LessonsCubit(streamLessonsUseCase: mockStreamLessonsUseCase);
      },
      act: (cubit) => cubit.initialize(),
      expect:
          () => <Matcher>[isA<LessonsLoading>(), isA<LessonsEmpty>()],
    );

    blocTest<LessonsCubit, LessonsState>(
      'emits [LessonsLoading, LessonsFailure] on failure',
      build: () {
        when(
          () => mockStreamLessonsUseCase(),
        ).thenAnswer((_) => Stream.value(const Left(tAppError)));
        return LessonsCubit(streamLessonsUseCase: mockStreamLessonsUseCase);
      },
      act: (cubit) => cubit.initialize(),
      expect:
          () => <Matcher>[
            isA<LessonsLoading>(),
            isA<LessonsFailure>().having(
              (state) => state.error.code,
              'error.code',
              tAppError.code,
            ),
          ],
    );
  });
}
