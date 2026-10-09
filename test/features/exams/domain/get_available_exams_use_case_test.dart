import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/exams/domain/entities/student_exam_entity.dart';
import 'package:al_mobdea/features/exams/domain/entities/student_exam_list_item_entity.dart';
import 'package:al_mobdea/features/exams/domain/entities/student_exam_status.dart';
import 'package:al_mobdea/features/exams/domain/repositories/student_exams_repository.dart';
import 'package:al_mobdea/features/exams/domain/use_cases/stream_available_exams_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStudentExamsRepository extends Mock implements StudentExamsRepository {}

void main() {
  const String gradeId = 'grade-1';

  const AppErrorModel failure = AppErrorModel(
    code: 'exams/stream-failed',
    message: 'Failed to load available exams',
    type: AppErrorType.network,
    isRetryable: true,
  );

  late MockStudentExamsRepository repository;
  late StreamAvailableExamsUseCase useCase;

  setUp(() {
    repository = MockStudentExamsRepository();
    useCase = StreamAvailableExamsUseCase(repository: repository);
  });

  group('StreamAvailableExamsUseCase', () {
    test('should return active exam when available', () async {
      // arrange
      final StudentExamListItemEntity examItem = _buildPublishedExamItem();

      when(() => repository.streamAvailableExams(gradeId: any(named: 'gradeId'))).thenAnswer(
        (_) => Stream<Either<AppErrorModel, List<StudentExamListItemEntity>>>.value(
          Right<AppErrorModel, List<StudentExamListItemEntity>>(<StudentExamListItemEntity>[
            examItem,
          ]),
        ),
      );

      // act
      final List<Either<AppErrorModel, List<StudentExamListItemEntity>>> emissions = await useCase(
        gradeId: gradeId,
      ).toList();

      // assert
      expect(emissions, hasLength(1));

      final List<StudentExamListItemEntity> exams = emissions.single.fold(
        (_) => fail('Expected available exams, but received a failure'),
        (List<StudentExamListItemEntity> exams) => exams,
      );

      expect(exams, <StudentExamListItemEntity>[examItem]);
      expect(exams.single.exam.examId, 'exam-1');

      verify(() => repository.streamAvailableExams(gradeId: gradeId)).called(1);
    });

    test('should return failure when repository fails', () async {
      // arrange
      when(() => repository.streamAvailableExams(gradeId: any(named: 'gradeId'))).thenAnswer(
        (_) => Stream<Either<AppErrorModel, List<StudentExamListItemEntity>>>.value(
          const Left<AppErrorModel, List<StudentExamListItemEntity>>(failure),
        ),
      );

      // act
      final List<Either<AppErrorModel, List<StudentExamListItemEntity>>> emissions = await useCase(
        gradeId: gradeId,
      ).toList();

      // assert
      expect(emissions, hasLength(1));

      final AppErrorModel error = emissions.single.fold(
        (AppErrorModel error) => error,
        (_) => fail('Expected a failure, but received available exams'),
      );

      expect(error, same(failure));

      verify(() => repository.streamAvailableExams(gradeId: gradeId)).called(1);
    });
  });
}

StudentExamListItemEntity _buildPublishedExamItem() {
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
