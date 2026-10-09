import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/profile/domain/entities/profile_entity.dart';
import 'package:al_mobdea/features/profile/domain/use_cases/stream_student_profile_use_case.dart';
import 'package:al_mobdea/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockStreamStudentProfileUseCase extends Mock
    implements StreamStudentProfileUseCase {}

void main() {
  const failure = AppErrorModel(
    code: 'unavailable',
    message: 'تعذر تحميل بيانات الملف الشخصي، حاول مرة أخرى.',
    type: AppErrorType.network,
    isRetryable: true,
  );

  late MockStreamStudentProfileUseCase streamStudentProfileUseCase;
  late ProfileEntity profile;

  setUp(() {
    streamStudentProfileUseCase = MockStreamStudentProfileUseCase();

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

  ProfileCubit buildCubit() {
    return ProfileCubit(
      streamStudentProfileUseCase: streamStudentProfileUseCase,
    );
  }

  blocTest<ProfileCubit, ProfileState>(
    'emits [ProfileLoading, ProfileSuccess] when profile fetch succeeds',
    build: () {
      when(() => streamStudentProfileUseCase()).thenAnswer(
        (_) => Stream<Either<AppErrorModel, ProfileEntity>>.value(
          Right<AppErrorModel, ProfileEntity>(profile),
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
    'emits [ProfileLoading, ProfileFailure] when profile fetch fails',
    build: () {
      when(() => streamStudentProfileUseCase()).thenAnswer(
        (_) => Stream<Either<AppErrorModel, ProfileEntity>>.value(
          Left<AppErrorModel, ProfileEntity>(failure),
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
}
