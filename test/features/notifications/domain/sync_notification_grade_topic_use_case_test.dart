import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/notifications/domain/repositories/notification_repository.dart';
import 'package:al_mobdea/features/notifications/domain/use_cases/sync_notification_grade_topic_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockNotificationRepository extends Mock
    implements NotificationRepository {}

void main() {
  const gradeId = 'grade-3';

  late MockNotificationRepository repository;
  late SyncNotificationGradeTopicUseCase useCase;

  setUp(() {
    repository = MockNotificationRepository();
    useCase = SyncNotificationGradeTopicUseCase(repository: repository);
  });

  group('SyncNotificationGradeTopicUseCase', () {
    test('should call repository.syncGradeTopic with given gradeId', () async {
      // Arrange
      when(() => repository.syncGradeTopic(gradeId: gradeId))
          .thenAnswer((_) async => Right<AppErrorModel, void>(null));

      // Act
      final result = await useCase(gradeId: gradeId);

      // Assert
      verify(() => repository.syncGradeTopic(gradeId: gradeId)).called(1);
      verifyNoMoreInteractions(repository);
      expect(result.isRight(), isTrue, reason: 'Expected a Right result.');
    });

    test(
      'should return Left with AppErrorModel when repository fails',
      () async {
        // Arrange
        const failure = AppErrorModel(
          code: 'unavailable',
          message: 'تعذر مزامنة إشعارات الصف، حاول مرة أخرى.',
          type: AppErrorType.network,
          isRetryable: true,
        );

        when(() => repository.syncGradeTopic(gradeId: gradeId))
            .thenAnswer((_) async => Left<AppErrorModel, void>(failure));

        // Act
        final result = await useCase(gradeId: gradeId);

        // Assert
        verify(() => repository.syncGradeTopic(gradeId: gradeId)).called(1);
        expect(result.isLeft(), isTrue, reason: 'Expected a Left result.');

        result.fold((error) {
          expect(error.code, failure.code);
          expect(error.message, failure.message);
          expect(error.type, failure.type);
          expect(error.isRetryable, failure.isRetryable);
        }, (_) => fail('Expected Left(AppErrorModel), got Right.'));
      },
    );
  });
}
