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

  const profile = ProfileEntity(
    studentProfile: StudentProfileEntity(
      name: 'أحمد محمد',
      gradeId: 'grade-3',
      email: 'student@almobdea.com',
    ),
    grade: GradeEntity(name: 'الصف الثالث الثانوي'),
  );

  setUp(() {
    repository = MockProfileRepository();

    useCase = StreamStudentProfileUseCase(repository: repository);
  });

  group('StreamStudentProfileUseCase', () {
    test('returns student profile details', () async {
      when(() => repository.streamStudentProfile()).thenAnswer(
        (_) => Stream<Either<AppErrorModel, ProfileEntity>>.value(
          const Right<AppErrorModel, ProfileEntity>(profile),
        ),
      );

      final result = await useCase().first;

      verify(() => repository.streamStudentProfile()).called(1);

      result.fold(
        (error) {
          fail('Expected a profile, got ${error.code}.');
        },
        (entity) {
          expect(entity.studentProfile.name, 'أحمد محمد');
          expect(entity.studentProfile.gradeId, 'grade-3');
          expect(entity.studentProfile.email, 'student@almobdea.com');
          expect(entity.grade.name, 'الصف الثالث الثانوي');
        },
      );
    });

    test('returns the repository error', () async {
      const failure = AppErrorModel(
        code: 'permission-denied',
        message: 'لا تملك صلاحية الوصول إلى هذه البيانات.',
        type: AppErrorType.authorization,
        isRetryable: false,
      );

      when(() => repository.streamStudentProfile()).thenAnswer(
        (_) => Stream<Either<AppErrorModel, ProfileEntity>>.value(
          const Left<AppErrorModel, ProfileEntity>(failure),
        ),
      );

      final result = await useCase().first;

      verify(() => repository.streamStudentProfile()).called(1);

      result.fold(
        (error) {
          expect(error, same(failure));
        },
        (_) {
          fail('Expected an error, got a profile.');
        },
      );
    });
  });
}
