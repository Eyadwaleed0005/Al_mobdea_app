import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/lesson_quiz/domain/entity/lesson_quiz_entity.dart';
import 'package:al_mobdea/features/lesson_quiz/domain/entity/lesson_quiz_question_entity.dart';
import 'package:al_mobdea/features/lesson_quiz/domain/entity/lesson_quiz_result_entity.dart';
import 'package:al_mobdea/features/lesson_quiz/domain/usecase/calculate_lesson_quiz_result_use_case.dart';
import 'package:al_mobdea/features/lesson_quiz/domain/usecase/lesson_quiz_usecase.dart';
import 'package:al_mobdea/features/lesson_quiz/presentation/cubit/lesson_quiz_cubit.dart';
import 'package:al_mobdea/features/lesson_quiz/presentation/cubit/lesson_quiz_session_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockGetLessonQuizUseCase extends Mock implements GetLessonQuizUseCase {}

class MockSubmitLessonQuizUseCase extends Mock {
  LessonQuizResultEntity call({
    required LessonQuizEntity quiz,
    required Map<String, int> selectedAnswers,
  }) => const LessonQuizResultEntity(
    correctAnswersCount: 2,
    totalQuestions: 3,
    earnedScore: 20,
    totalScore: 30,
  );
}

void main() {
  late MockGetLessonQuizUseCase mockGetLessonQuizUseCase;

  setUp(() {
    mockGetLessonQuizUseCase = MockGetLessonQuizUseCase();
  });

  final tQuiz = LessonQuizEntity(
    lessonId: 'lesson_001',
    questions: const [
      LessonQuizQuestionEntity(
        questionId: 'q1',
        questionText: 'Question 1',
        options: ['A', 'B', 'C'],
        correctOptionIndex: 1,
        score: 10,
      ),
      LessonQuizQuestionEntity(
        questionId: 'q2',
        questionText: 'Question 2',
        options: ['X', 'Y', 'Z'],
        correctOptionIndex: 0,
        score: 10,
      ),
      LessonQuizQuestionEntity(
        questionId: 'q3',
        questionText: 'Question 3',
        options: ['M', 'N'],
        correctOptionIndex: 1,
        score: 10,
      ),
    ],
  );

  blocTest<LessonQuizCubit, LessonQuizState>(
    'emits [LessonQuizLoading, LessonQuizSuccess] when quiz loads',
    build: () => LessonQuizCubit(getLessonQuizUseCase: mockGetLessonQuizUseCase),
    act: (cubit) => cubit.loadLessonQuiz(lessonId: 'lesson_001'),
    wait: const Duration(milliseconds: 100),
    expect: () => [isA<LessonQuizLoading>(), isA<LessonQuizSuccess>()],
    setUp: () {
      when(() => mockGetLessonQuizUseCase(lessonId: 'lesson_001'))
          .thenAnswer((_) async => right(tQuiz));
    },
  );

  test('selecting option updates selectedAnswers in session state', () {
    final sessionCubit = LessonQuizSessionCubit(
      quiz: tQuiz,
      calculateResultUseCase: const CalculateLessonQuizResultUseCase(),
    );

    sessionCubit.selectAnswer(questionId: 'q1', optionIndex: 1);

    expect(sessionCubit.state.selectedAnswers['q1'], 1);
    sessionCubit.close();
  });

  blocTest<LessonQuizCubit, LessonQuizState>(
    'emits [LessonQuizLoading, LessonQuizFailure] on error',
    build: () => LessonQuizCubit(getLessonQuizUseCase: mockGetLessonQuizUseCase),
    act: (cubit) => cubit.loadLessonQuiz(lessonId: 'lesson_001'),
    wait: const Duration(milliseconds: 100),
    expect: () => [isA<LessonQuizLoading>(), isA<LessonQuizFailure>()],
    setUp: () {
      when(() => mockGetLessonQuizUseCase(lessonId: 'lesson_001')).thenAnswer(
        (_) async => left(
          AppErrorModel(
            code: 'error',
            message: 'server error',
            type: AppErrorType.server,
            isRetryable: false,
          ),
        ),
      );
    },
  );
}
