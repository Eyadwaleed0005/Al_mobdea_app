import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/exams/domain/entities/cached_exam_attempt_entity.dart';
import 'package:al_mobdea/features/exams/domain/entities/student_exam_entity.dart';
import 'package:al_mobdea/features/exams/domain/entities/student_exam_list_item_entity.dart';
import 'package:al_mobdea/features/exams/domain/entities/student_exam_status.dart';
import 'package:al_mobdea/features/exams/domain/use_cases/get_pending_exam_submissions_use_case.dart';
import 'package:al_mobdea/features/exams/domain/use_cases/resume_student_exam_use_case.dart';
import 'package:al_mobdea/features/exams/domain/use_cases/start_student_exam_use_case.dart';
import 'package:al_mobdea/features/exams/domain/use_cases/stream_available_exams_use_case.dart';
import 'package:al_mobdea/features/exams/presentation/cubit/exams_screen_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStreamAvailableExamsUseCase extends Mock implements StreamAvailableExamsUseCase {}

class MockStartStudentExamUseCase extends Mock implements StartStudentExamUseCase {}

class MockResumeStudentExamUseCase extends Mock implements ResumeStudentExamUseCase {}

class MockGetPendingExamSubmissionsUseCase extends Mock
    implements GetPendingExamSubmissionsUseCase {}

void main() {
  const String gradeId = 'grade-1';

  const AppErrorModel failure = AppErrorModel(
    code: 'exams/stream-failed',
    message: 'Failed to load available exams',
    type: AppErrorType.network,
    isRetryable: true,
  );

  late MockStreamAvailableExamsUseCase streamAvailableExamsUseCase;
  late MockStartStudentExamUseCase startStudentExamUseCase;
  late MockResumeStudentExamUseCase resumeStudentExamUseCase;
  late MockGetPendingExamSubmissionsUseCase getPendingExamSubmissionsUseCase;
  late ExamsScreenCubit cubit;

  setUp(() {
    streamAvailableExamsUseCase = MockStreamAvailableExamsUseCase();
    startStudentExamUseCase = MockStartStudentExamUseCase();
    resumeStudentExamUseCase = MockResumeStudentExamUseCase();
    getPendingExamSubmissionsUseCase = MockGetPendingExamSubmissionsUseCase();

    when(() => getPendingExamSubmissionsUseCase()).thenAnswer(
      (_) async =>
          const Right<AppErrorModel, List<CachedExamAttemptEntity>>(<CachedExamAttemptEntity>[]),
    );

    cubit = ExamsScreenCubit(
      streamAvailableExamsUseCase: streamAvailableExamsUseCase,
      startStudentExamUseCase: startStudentExamUseCase,
      resumeStudentExamUseCase: resumeStudentExamUseCase,
      getPendingExamSubmissionsUseCase: getPendingExamSubmissionsUseCase,
    );
  });

  group('ExamsScreenCubit', () {
    blocTest<ExamsScreenCubit, ExamsScreenState>(
      'emits [ExamsScreenLoading, ExamsScreenSuccess] when exam exists',
      build: () {
        when(() => streamAvailableExamsUseCase(gradeId: any(named: 'gradeId')))
            .thenAnswer((_) => _streamWith(<StudentExamListItemEntity>[_buildActiveExam()]));
        return cubit;
      },
      act: (ExamsScreenCubit cubit) => cubit.loadExams(gradeId: gradeId),
      expect: () => <Matcher>[
        isA<ExamsScreenLoading>(),
        isA<ExamsScreenSuccess>()
            .having((ExamsScreenSuccess state) => state.exams, 'exams', hasLength(1))
            .having(
              (ExamsScreenSuccess state) => state.exams.single.exam.examId,
              'exam id',
              'exam-1',
            ),
      ],
      verify: (_) {
        verify(() => streamAvailableExamsUseCase(gradeId: gradeId)).called(1);
      },
    );

    blocTest<ExamsScreenCubit, ExamsScreenState>(
      'emits [ExamsScreenLoading, ExamsScreenEmpty] when no active exam',
      build: () {
        when(() => streamAvailableExamsUseCase(gradeId: any(named: 'gradeId')))
            .thenAnswer((_) => _streamWith(const <StudentExamListItemEntity>[]));
        return cubit;
      },
      act: (ExamsScreenCubit cubit) => cubit.loadExams(gradeId: gradeId),
      expect: () => <Matcher>[isA<ExamsScreenLoading>(), isA<ExamsScreenEmpty>()],
    );

    blocTest<ExamsScreenCubit, ExamsScreenState>(
      'emits [ExamsScreenLoading, ExamsScreenFailure] when the stream fails',
      build: () {
        when(() => streamAvailableExamsUseCase(gradeId: any(named: 'gradeId')))
            .thenAnswer((_) => _streamFailure(failure));
        return cubit;
      },
      act: (ExamsScreenCubit cubit) => cubit.loadExams(gradeId: gradeId),
      expect: () => <Matcher>[
        isA<ExamsScreenLoading>(),
        isA<ExamsScreenFailure>().having(
          (ExamsScreenFailure state) => state.error,
          'error',
          same(failure),
        ),
      ],
    );
  });
}

StudentExamListItemEntity _buildActiveExam() {
  final DateTime now = DateTime.now().toUtc();

  return StudentExamListItemEntity(
    exam: StudentExamEntity(
      examId: 'exam-1',
      gradeId: 'grade-1',
      examName: 'Math Exam',
      questionCount: 10,
      durationMinutes: 30,
      totalScore: 100,
      status: StudentExamStatus.published,
      createdAt: now,
      updatedAt: now,
    ),
  );
}

Stream<Either<AppErrorModel, List<StudentExamListItemEntity>>> _streamWith(
  List<StudentExamListItemEntity> exams,
) {
  return Stream<Either<AppErrorModel, List<StudentExamListItemEntity>>>.value(
    Right<AppErrorModel, List<StudentExamListItemEntity>>(exams),
  );
}

Stream<Either<AppErrorModel, List<StudentExamListItemEntity>>> _streamFailure(AppErrorModel error) {
  return Stream<Either<AppErrorModel, List<StudentExamListItemEntity>>>.value(
    Left<AppErrorModel, List<StudentExamListItemEntity>>(error),
  );
}
