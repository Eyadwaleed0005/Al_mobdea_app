import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/profile/domain/entities/profile_entity.dart';
import 'package:al_mobdea/features/profile/domain/use_cases/stream_student_profile_use_case.dart';
import 'package:al_mobdea/features/profile/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStreamStudentProfileUseCase extends Mock
    implements StreamStudentProfileUseCase {}

void main() {
  late MockStreamStudentProfileUseCase streamStudentProfileUseCase;

  const profile = ProfileEntity(
    studentProfile: StudentProfileEntity(
      name: 'أحمد محمد',
      gradeId: 'grade-3',
      email: 'student@almobdea.com',
    ),
    grade: GradeEntity(name: 'الصف الثالث الثانوي'),
  );

  const failure = AppErrorModel(
    code: 'unavailable',
    message: 'تعذر تحميل بيانات الملف الشخصي، حاول مرة أخرى.',
    type: AppErrorType.network,
    isRetryable: true,
  );

  setUp(() {
    streamStudentProfileUseCase = MockStreamStudentProfileUseCase();
  });

  ProfileCubit buildCubit() {
    return ProfileCubit(
      streamStudentProfileUseCase: streamStudentProfileUseCase,
    );
  }

  group('ProfileCubit', () {
    blocTest<ProfileCubit, ProfileState>(
      'emits loading then success when profile loading succeeds',
      build: () {
        when(() => streamStudentProfileUseCase()).thenAnswer(
          (_) => Stream<Either<AppErrorModel, ProfileEntity>>.value(
            const Right<AppErrorModel, ProfileEntity>(profile),
          ),
        );

        return buildCubit();
      },
      act: (cubit) => cubit.initialize(),
      wait: Duration.zero,
      expect: () => [
        isA<ProfileLoading>(),
        isA<ProfileSuccess>().having(
          (state) => state.profile,
          'profile',
          same(profile),
        ),
      ],
      verify: (_) {
        verify(() => streamStudentProfileUseCase()).called(1);
      },
    );

    blocTest<ProfileCubit, ProfileState>(
      'emits loading then failure when profile loading fails',
      build: () {
        when(() => streamStudentProfileUseCase()).thenAnswer(
          (_) => Stream<Either<AppErrorModel, ProfileEntity>>.value(
            const Left<AppErrorModel, ProfileEntity>(failure),
          ),
        );

        return buildCubit();
      },
      act: (cubit) => cubit.initialize(),
      wait: Duration.zero,
      expect: () => [
        isA<ProfileLoading>(),
        isA<ProfileFailure>().having(
          (state) => state.error,
          'error',
          same(failure),
        ),
      ],
      verify: (_) {
        verify(() => streamStudentProfileUseCase()).called(1);
      },
    );
  });
}
