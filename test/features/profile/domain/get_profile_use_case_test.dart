import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/profile/domain/entities/profile_entity.dart';
import 'package:al_mobdea/features/profile/domain/repositories/profile_repository.dart';
import 'package:al_mobdea/features/profile/domain/use_cases/stream_student_profile_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  late MockProfileRepository repository;
  late StreamStudentProfileUseCase useCase;
  late ProfileEntity profile;

  setUp(() {
    repository = MockProfileRepository();
    useCase = StreamStudentProfileUseCase(repository: repository);

    profile = ProfileEntity(
      studentProfile: StudentProfileEntity(
        name: 'أحمد محمد',
        gradeId: 'grade-3',
        email: 'student@almobdea.com',
        subscriptionStartAt: DateTime.utc(2026, 1, 1),
        subscriptionEndAt: DateTime.utc(2026, 12, 31),
      ),
      grade: const GradeEntity(name: 'الصف الثالث الثانوي'),
    );
  });

  group('StreamStudentProfileUseCase', () {
    test('should return ProfileEntity with student details', () async {
      // Arrange
      when(() => repository.streamStudentProfile()).thenAnswer(
        (_) => Stream<Either<AppErrorModel, ProfileEntity>>.value(
          Right<AppErrorModel, ProfileEntity>(profile),
        ),
      );

      // Act
      final result = await useCase().first;

      // Assert
      verify(() => repository.streamStudentProfile()).called(1);
      expect(result.isRight(), isTrue, reason: 'Expected a Right result.');

      result.fold((failure) => fail('Expected Right(ProfileEntity), got Left(${failure.code}).'), (
        entity,
      ) {
        expect(entity.studentProfile.name, 'أحمد محمد');
        expect(entity.studentProfile.gradeId, 'grade-3');
        expect(entity.studentProfile.email, 'student@almobdea.com');
        expect(entity.studentProfile.subscriptionStartAt, DateTime.utc(2026, 1, 1));
        expect(entity.studentProfile.subscriptionEndAt, DateTime.utc(2026, 12, 31));
        expect(entity.grade.name, 'الصف الثالث الثانوي');
      });
    });

    test('should return Left with AppErrorModel when repository stream fails', () async {
      // Arrange
      const failure = AppErrorModel(
        code: 'permission-denied',
        message: 'لا تملك صلاحية الوصول إلى هذه البيانات.',
        type: AppErrorType.authorization,
        isRetryable: false,
      );

      when(() => repository.streamStudentProfile()).thenAnswer(
        (_) => Stream<Either<AppErrorModel, ProfileEntity>>.value(
          Left<AppErrorModel, ProfileEntity>(failure),
        ),
      );

      // Act
      final result = await useCase().first;

      // Assert
      verify(() => repository.streamStudentProfile()).called(1);
      expect(result.isLeft(), isTrue, reason: 'Expected a Left result.');

      result.fold((error) {
        expect(error.code, failure.code);
        expect(error.message, failure.message);
        expect(error.type, failure.type);
        expect(error.isRetryable, failure.isRetryable);
      }, (_) => fail('Expected Left(AppErrorModel), got Right(ProfileEntity).'));
    });
  });
}
