import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/exams/domain/entities/cached_exam_attempt_entity.dart';
import 'package:al_mobdea/features/exams/domain/entities/student_exam_attempt_entity.dart';
import 'package:al_mobdea/features/exams/domain/entities/student_exam_attempt_status.dart';
import 'package:al_mobdea/features/exams/domain/entities/student_exam_entity.dart';
import 'package:al_mobdea/features/exams/domain/entities/student_exam_question_entity.dart';
import 'package:al_mobdea/features/exams/domain/entities/student_exam_session_entity.dart';
import 'package:al_mobdea/features/exams/domain/entities/student_exam_status.dart';
import 'package:al_mobdea/features/exams/domain/use_cases/get_cached_exam_attempt_use_case.dart';
import 'package:al_mobdea/features/exams/domain/use_cases/save_exam_answer_use_case.dart';
import 'package:al_mobdea/features/exams/domain/use_cases/submit_student_exam_use_case.dart';
import 'package:al_mobdea/features/exams/presentation/cubit/start_exam_screen_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetCachedExamAttemptUseCase extends Mock implements GetCachedExamAttemptUseCase {}

class MockSaveExamAnswerUseCase extends Mock implements SaveExamAnswerUseCase {}

class MockSubmitStudentExamUseCase extends Mock implements SubmitStudentExamUseCase {}

void main() {
  late MockGetCachedExamAttemptUseCase getCachedExamAttemptUseCase;
  late MockSaveExamAnswerUseCase saveExamAnswerUseCase;
  late MockSubmitStudentExamUseCase submitStudentExamUseCase;
  late StudentExamSessionEntity session;
  late CachedExamAttemptEntity cachedAttempt;
  late StartExamScreenCubit cubit;

  setUp(() {
    getCachedExamAttemptUseCase = MockGetCachedExamAttemptUseCase();
    saveExamAnswerUseCase = MockSaveExamAnswerUseCase();
    submitStudentExamUseCase = MockSubmitStudentExamUseCase();

    session = _buildSession();
    cachedAttempt = _buildCachedAttempt(session);

    when(() => getCachedExamAttemptUseCase(resultId: any(named: 'resultId')))
        .thenAnswer((_) async => Right<AppErrorModel, CachedExamAttemptEntity>(cachedAttempt));

    cubit = StartExamScreenCubit(
      getCachedExamAttemptUseCase: getCachedExamAttemptUseCase,
      saveExamAnswerUseCase: saveExamAnswerUseCase,
      submitStudentExamUseCase: submitStudentExamUseCase,
    );
  });

  group('StartExamScreenCubit', () {
    blocTest<StartExamScreenCubit, StartExamScreenState>(
      'should select the answer and emit it in the ready state',
      build: () {
        when(
          () => saveExamAnswerUseCase(
            resultId: any(named: 'resultId'),
            questionId: any(named: 'questionId'),
            selectedChoiceIndex: any(named: 'selectedChoiceIndex'),
          ),
        ).thenAnswer((_) async => const Right<AppErrorModel, Unit>(unit));
        return cubit;
      },
      act: (StartExamScreenCubit cubit) async {
        await cubit.initialize(session: session);
        await cubit.saveAnswer(questionId: 'question-1', selectedChoiceIndex: 2);
      },
      expect: () => <Matcher>[
        isA<StartExamScreenLoading>(),
        isA<StartExamScreenReady>().having(
          (StartExamScreenReady state) => state.selectedChoiceIndexFor('question-1'),
          'selected choice before answering',
          isNull,
        ),
        isA<StartExamScreenReady>()
            .having(
              (StartExamScreenReady state) => state.selectedChoiceIndexFor('question-1'),
              'selected choice after answering',
              2,
            )
            .having(
              (StartExamScreenReady state) => state.answeredQuestionsCount,
              'answered questions count',
              1,
            ),
      ],
      verify: (_) {
        verify(
          () => saveExamAnswerUseCase(
            resultId: 'result-1',
            questionId: 'question-1',
            selectedChoiceIndex: 2,
          ),
        ).called(1);
      },
    );

    test('should decrease the remaining duration when the timer ticks', () async {
      // arrange
      await cubit.initialize(session: session);
      addTearDown(cubit.close);

      expect(cubit.state, isA<StartExamScreenReady>());
      final StartExamScreenReady initialState = cubit.state as StartExamScreenReady;
      expect(initialState.remainingDuration, greaterThan(Duration.zero));

      // act
      await Future<void>.delayed(const Duration(milliseconds: 1100));

      // assert
      expect(cubit.state, isA<StartExamScreenReady>());
      final StartExamScreenReady tickedState = cubit.state as StartExamScreenReady;
      expect(tickedState.remainingDuration, lessThan(initialState.remainingDuration));
      expect(tickedState.currentQuestionIndex, initialState.currentQuestionIndex);
    });
  });
}

StudentExamSessionEntity _buildSession() {
  final DateTime now = DateTime.now().toUtc();

  return StudentExamSessionEntity(
    exam: StudentExamEntity(
      examId: 'exam-1',
      gradeId: 'grade-1',
      examName: 'Math Exam',
      questionCount: 2,
      durationMinutes: 10,
      totalScore: 10,
      status: StudentExamStatus.published,
      createdAt: now,
      updatedAt: now,
    ),
    attempt: StudentExamAttemptEntity(
      resultId: 'result-1',
      examId: 'exam-1',
      studentId: 'student-1',
      status: StudentExamAttemptStatus.inProgress,
      totalScore: 10,
      startedAt: now,
      expiresAt: now.add(const Duration(minutes: 10)),
    ),
    questions: <StudentExamQuestionEntity>[
      StudentExamQuestionEntity(
        questionId: 'question-1',
        examId: 'exam-1',
        questionText: 'What is 2 + 2?',
        choices: const <String>['1', '2', '3', '4'],
        degree: 5,
        questionOrder: 1,
      ),
      StudentExamQuestionEntity(
        questionId: 'question-2',
        examId: 'exam-1',
        questionText: 'What is 3 + 3?',
        choices: const <String>['4', '5', '6', '7'],
        degree: 5,
        questionOrder: 2,
      ),
    ],
  );
}

CachedExamAttemptEntity _buildCachedAttempt(StudentExamSessionEntity session) {
  return CachedExamAttemptEntity(
    resultId: session.attempt.resultId,
    examId: session.exam.examId,
    questionIds: List<String>.unmodifiable(
      session.questions.map((StudentExamQuestionEntity question) {
        return question.questionId;
      }),
    ),
    selectedChoiceIndexes: const <String, int>{},
    startedAt: session.attempt.startedAt,
    expiresAt: session.attempt.expiresAt,
    isTimeExpired: false,
    isPendingSubmission: false,
    updatedAt: DateTime.now().toUtc(),
  );
}
