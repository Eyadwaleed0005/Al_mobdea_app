import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/live_session/domain/entity/live_session_entity.dart';
import 'package:al_mobdea/features/live_session/domain/use_cases/get_live_session_use_case.dart';
import 'package:al_mobdea/features/live_session/presentation/cubits/live_session_cubit/live_session_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockGetLiveSessionUseCase extends Mock implements GetLiveSessionUseCase {}

void main() {
  late MockGetLiveSessionUseCase mockGetLiveSessionUseCase;

  setUp(() {
    mockGetLiveSessionUseCase = MockGetLiveSessionUseCase();
  });

  final tSession = LiveSessionEntity(
    gradeId: 'grade_001',
    platformType: 'zoom',
    meetingUrl: 'https://zoom.us/j/123',
    createdAt: DateTime(2025, 1, 1),
    updatedAt: DateTime(2025, 1, 1),
  );

  blocTest<LiveSessionCubit, LiveSessionState>(
    'emits [LiveSessionLoading, LiveSessionActive] when session is ongoing',
    build: () => LiveSessionCubit(getLiveSessionUseCase: mockGetLiveSessionUseCase),
    act: (cubit) => cubit.getLiveSession(gradeId: 'grade_001'),
    wait: const Duration(milliseconds: 100),
    expect: () => [isA<LiveSessionLoading>(), isA<LiveSessionSuccess>()],
    setUp: () {
      when(() => mockGetLiveSessionUseCase.getLiveSession(gradeId: 'grade_001'))
          .thenAnswer((_) async => right(tSession));
    },
  );

  blocTest<LiveSessionCubit, LiveSessionState>(
    'emits [LiveSessionLoading, LiveSessionNoActiveSession] when no session',
    build: () => LiveSessionCubit(getLiveSessionUseCase: mockGetLiveSessionUseCase),
    act: (cubit) => cubit.getLiveSession(gradeId: 'grade_001'),
    wait: const Duration(milliseconds: 100),
    expect: () => [isA<LiveSessionLoading>(), isA<LiveSessionFailure>()],
    setUp: () {
      when(() => mockGetLiveSessionUseCase.getLiveSession(gradeId: 'grade_001')).thenAnswer(
        (_) async => left(
          AppErrorModel(
            code: 'not_found',
            message: 'no active session',
            type: AppErrorType.notFound,
            isRetryable: false,
          ),
        ),
      );
    },
  );
}
