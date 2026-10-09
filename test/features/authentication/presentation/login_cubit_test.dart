import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/authentication/domain/entity/login_entity.dart';
import 'package:al_mobdea/features/authentication/domain/usecase/login_usecase.dart';
import 'package:al_mobdea/features/authentication/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  late MockLoginUseCase mockLoginUseCase;

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
    mockLoginUseCase = MockLoginUseCase();
  });

  group('LoginCubit', () {
    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoading, LoginSuccess] when login succeeds',
      build: () {
        when(
          () => mockLoginUseCase.login(email: any(named: 'email'), password: any(named: 'password')),
        ).thenAnswer((_) async => Right(tLoginEntity));
        return LoginCubit(loginUseCase: mockLoginUseCase);
      },
      act: (cubit) => cubit.login(email: tEmail, password: tPassword),
      expect: () => <LoginState>[
        LoginLoading(),
        LoginSuccess(loginEntity: tLoginEntity),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'emits [LoginLoading, LoginFailure] when login returns a Failure',
      build: () {
        when(
          () => mockLoginUseCase.login(email: any(named: 'email'), password: any(named: 'password')),
        ).thenAnswer((_) async => Left(tAppError));
        return LoginCubit(loginUseCase: mockLoginUseCase);
      },
      act: (cubit) => cubit.login(email: tEmail, password: tPassword),
      expect: () => <LoginState>[
        LoginLoading(),
        LoginFailure(errorMessage: tAppError.message),
      ],
    );
  });
}
