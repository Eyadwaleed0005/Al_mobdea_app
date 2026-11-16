import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/lessons/domain/entities/lesson_entity.dart';
import 'package:al_mobdea/features/lessons/domain/use_cases/check_lesson_access_use_case.dart';
import 'package:al_mobdea/features/lessons/domain/use_cases/stream_lessons_use_case.dart';
import 'package:al_mobdea/features/lessons/presentation/cubit/lessons_cubit.dart';
import 'package:al_mobdea/features/lessons/presentation/cubit/lessons_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStreamLessonsUseCase extends Mock implements StreamLessonsUseCase {}

class MockCheckLessonAccessUseCase extends Mock
    implements CheckLessonAccessUseCase {}

void main() {
  late MockStreamLessonsUseCase mockStreamLessonsUseCase;
  late MockCheckLessonAccessUseCase mockCheckLessonAccessUseCase;

  const tFreeLesson = LessonEntity(
    lessonId: 'lesson-1',
    title: 'الدرس الأول',
    description: 'شرح الدرس الأول',
    gradeId: 'grade-1',
    isPublished: true,
    isFree: true,
    youtubeUrl: 'https://youtube.com/watch?v=dQw4w9WgXcQ',
    pdfStoragePath: 'lessons/lesson-1.pdf',
    pdfFileName: 'lesson-1.pdf',
    pdfFileSize: 1024,
  );

  const tPaidLesson = LessonEntity(
    lessonId: 'lesson-2',
    title: 'الدرس الثاني',
    description: 'شرح الدرس الثاني',
    gradeId: 'grade-1',
    isPublished: true,
    isFree: false,
    youtubeUrl: '',
    pdfStoragePath: 'lessons/lesson-2.pdf',
    pdfFileName: 'lesson-2.pdf',
    pdfFileSize: 2048,
  );

  const tLessons = <LessonEntity>[tFreeLesson, tPaidLesson];

  const tAppError = AppErrorModel(
    code: 'firestore-error',
    message: 'تعذر تحميل الدروس',
    type: AppErrorType.unknown,
    isRetryable: true,
  );

  setUp(() {
    mockStreamLessonsUseCase = MockStreamLessonsUseCase();
    mockCheckLessonAccessUseCase = MockCheckLessonAccessUseCase();

    when(() => mockCheckLessonAccessUseCase.checkSubscription())
        .thenAnswer((_) async => const Right<AppErrorModel, bool>(false));

    when(() => mockStreamLessonsUseCase()).thenAnswer(
      (_) => Stream.value(
        const Right<AppErrorModel, List<LessonEntity>>(tLessons),
      ),
    );
  });

  LessonsCubit buildCubit() {
    return LessonsCubit(
      streamLessonsUseCase: mockStreamLessonsUseCase,
      checkLessonAccessUseCase: mockCheckLessonAccessUseCase,
    );
  }

  Future<void> initializeAndWait(LessonsCubit cubit) async {
    final ready = cubit.stream.firstWhere(
      (state) => state is LessonsDataSuccess,
    );

    await cubit.initialize();
    await ready;
  }

  group('LessonsCubit', () {
    blocTest<LessonsCubit, LessonsState>(
      'shows free lessons by default',
      build: buildCubit,
      act: (cubit) => cubit.initialize(),
      expect: () => <Matcher>[
        isA<LessonsLoading>(),
        isA<LessonsDataSuccess>()
            .having((state) => state.lessons, 'lessons', const [tFreeLesson])
            .having((state) => state.showFree, 'showFree', true)
            .having((state) => state.query, 'query', '')
            .having(
              (state) => state.hasValidSubscription,
              'hasValidSubscription',
              false,
            ),
      ],
    );

    blocTest<LessonsCubit, LessonsState>(
      'emits empty when no lessons are available',
      build: () {
        when(() => mockStreamLessonsUseCase()).thenAnswer(
          (_) => Stream.value(
            const Right<AppErrorModel, List<LessonEntity>>(<LessonEntity>[]),
          ),
        );

        return buildCubit();
      },
      act: (cubit) => cubit.initialize(),
      expect: () => <Matcher>[isA<LessonsLoading>(), isA<LessonsEmpty>()],
    );

    blocTest<LessonsCubit, LessonsState>(
      'emits failure when loading lessons fails',
      build: () {
        when(() => mockStreamLessonsUseCase()).thenAnswer(
          (_) => Stream.value(
            const Left<AppErrorModel, List<LessonEntity>>(tAppError),
          ),
        );

        return buildCubit();
      },
      act: (cubit) => cubit.initialize(),
      expect: () => <Matcher>[
        isA<LessonsLoading>(),
        isA<LessonsFailure>().having(
          (state) => state.error.code,
          'error.code',
          tAppError.code,
        ),
      ],
    );

    blocTest<LessonsCubit, LessonsState>(
      'shows paid lessons when the subscription filter is selected',
      build: buildCubit,
      act: (cubit) async {
        await initializeAndWait(cubit);
        cubit.selectAccessType(false);
      },
      expect: () => <Matcher>[
        isA<LessonsLoading>(),
        isA<LessonsDataSuccess>().having(
          (state) => state.lessons,
          'lessons',
          const [tFreeLesson],
        ),
        isA<LessonsDataSuccess>()
            .having((state) => state.lessons, 'lessons', const [tPaidLesson])
            .having((state) => state.showFree, 'showFree', false),
      ],
    );

    blocTest<LessonsCubit, LessonsState>(
      'search only returns lessons matching the selected access type',
      build: buildCubit,
      act: (cubit) async {
        await initializeAndWait(cubit);
        cubit.search('الثاني');
        cubit.selectAccessType(false);
      },
      expect: () => <Matcher>[
        isA<LessonsLoading>(),
        isA<LessonsDataSuccess>().having(
          (state) => state.lessons,
          'lessons',
          const [tFreeLesson],
        ),
        isA<LessonsDataSuccess>()
            .having((state) => state.lessons, 'lessons', isEmpty)
            .having((state) => state.hasNoResults, 'hasNoResults', true),
        isA<LessonsDataSuccess>()
            .having((state) => state.lessons, 'lessons', const [tPaidLesson])
            .having((state) => state.query, 'query', 'الثاني')
            .having((state) => state.showFree, 'showFree', false),
      ],
    );

    blocTest<LessonsCubit, LessonsState>(
      'keeps free lessons available when subscription checking fails',
      build: () {
        when(
          () => mockCheckLessonAccessUseCase.checkSubscription(),
        ).thenAnswer((_) async => const Left<AppErrorModel, bool>(tAppError));

        return buildCubit();
      },
      act: (cubit) => cubit.initialize(),
      expect: () => <Matcher>[
        isA<LessonsLoading>(),
        isA<LessonsDataSuccess>()
            .having((state) => state.lessons, 'lessons', const [tFreeLesson])
            .having(
              (state) => state.hasValidSubscription,
              'hasValidSubscription',
              isNull,
            )
            .having(
              (state) => state.subscriptionError,
              'subscriptionError',
              same(tAppError),
            ),
      ],
    );

    blocTest<LessonsCubit, LessonsState>(
      'refreshes subscription status when checking access to a paid lesson',
      build: () {
        when(() => mockCheckLessonAccessUseCase(lesson: tPaidLesson))
            .thenAnswer((_) async => const Right<AppErrorModel, bool>(true));

        return buildCubit();
      },
      act: (cubit) async {
        await initializeAndWait(cubit);

        final result = await cubit.checkLessonAccess(lesson: tPaidLesson);

        expect(result, const Right<AppErrorModel, bool>(true));
      },
      expect: () => <Matcher>[
        isA<LessonsLoading>(),
        isA<LessonsDataSuccess>().having(
          (state) => state.hasValidSubscription,
          'hasValidSubscription',
          false,
        ),
        isA<LessonsDataSuccess>()
            .having(
              (state) => state.hasValidSubscription,
              'hasValidSubscription',
              true,
            )
            .having((state) => state.lessons, 'lessons', const [tFreeLesson]),
      ],
      verify: (_) {
        verify(() => mockCheckLessonAccessUseCase(lesson: tPaidLesson))
            .called(1);
      },
    );
  });
}
