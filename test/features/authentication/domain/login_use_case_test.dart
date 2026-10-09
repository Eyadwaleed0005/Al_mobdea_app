import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/authentication/domain/entity/login_entity.dart';
import 'package:al_mobdea/features/authentication/domain/repositories/login_repo.dart';
import 'package:al_mobdea/features/authentication/domain/usecase/login_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginRepo extends Mock implements LoginRepo {}

void main() {
  late MockLoginRepo mockLoginRepo;
  late LoginUseCase loginUseCase;

  const tEmail = 'student@test.com';
  const tPassword = 'password123';
  final tLoginEntity = LoginEntity(email: tEmail);
  const tAppError = AppErrorModel(
    code: 'invalid-credentials',
    message: 'Invalid email or password',
    type: AppErrorType.authentication,
    isRetryable: false,
  );

  setUp(() {
    mockLoginRepo = MockLoginRepo();
    loginUseCase = LoginUseCase(repo: mockLoginRepo);
  });

  group('LoginUseCase', () {
    test(
      'should return LoginEntity when login is successful',
      () async {
        // arrange
        when(
          () => mockLoginRepo.login(email: any(named: 'email'), password: any(named: 'password')),
        ).thenAnswer((_) async => Right(tLoginEntity));

        // act
        final result = await loginUseCase.login(email: tEmail, password: tPassword);

        // assert
        expect(result, Right(tLoginEntity));
        verify(
          () => mockLoginRepo.login(email: tEmail, password: tPassword),
        ).called(1);
        verifyNoMoreInteractions(mockLoginRepo);
      },
    );

    test(
      'should return AppErrorModel when login fails',
      () async {
        // arrange
        when(
          () => mockLoginRepo.login(email: any(named: 'email'), password: any(named: 'password')),
        ).thenAnswer((_) async => Left(tAppError));

        // act
        final result = await loginUseCase.login(email: tEmail, password: tPassword);

        // assert
        expect(result, Left(tAppError));
        verify(
          () => mockLoginRepo.login(email: tEmail, password: tPassword),
        ).called(1);
        verifyNoMoreInteractions(mockLoginRepo);
      },
    );
  });
}
