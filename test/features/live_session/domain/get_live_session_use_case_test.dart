import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/live_session/domain/entity/live_session_entity.dart';
import 'package:al_mobdea/features/live_session/domain/repositories/live_session_repository.dart';
import 'package:al_mobdea/features/live_session/domain/use_cases/get_live_session_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';

class MockLiveSessionRepository extends Mock implements LiveSessionRepository {}

void main() {
  late MockLiveSessionRepository repository;
  late GetLiveSessionUseCase useCase;

  setUp(() {
    repository = MockLiveSessionRepository();
    useCase = GetLiveSessionUseCase(repository: repository);
  });

  final tGradeId = 'grade_001';
  final tEntity = LiveSessionEntity(
    gradeId: tGradeId,
    platformType: 'zoom',
    meetingUrl: 'https://zoom.us/j/123',
    createdAt: DateTime(2025, 1, 1),
    updatedAt: DateTime(2025, 1, 1),
  );

  test('should return LiveSessionEntity when stream emits session', () async {
    when(() => repository.getLiveSession(gradeId: tGradeId))
        .thenAnswer((_) async => right(tEntity));

    final result = await useCase.getLiveSession(gradeId: tGradeId);

    expect(result, right(tEntity));
    verify(() => repository.getLiveSession(gradeId: tGradeId)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should return Left(AppErrorModel) when repository fails', () async {
    final tError = AppErrorModel(
      code: 'error',
      message: 'something went wrong',
      type: AppErrorType.server,
      isRetryable: false,
    );
    when(() => repository.getLiveSession(gradeId: tGradeId))
        .thenAnswer((_) async => left(tError));

    final result = await useCase.getLiveSession(gradeId: tGradeId);

    expect(result, left(tError));
    verify(() => repository.getLiveSession(gradeId: tGradeId)).called(1);
    verifyNoMoreInteractions(repository);
  });
}