import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/notifications/domain/entities/app_notification_entity.dart';
import 'package:al_mobdea/features/notifications/domain/use_cases/get_initial_notification_use_case.dart';
import 'package:al_mobdea/features/notifications/domain/use_cases/initialize_notifications_use_case.dart';
import 'package:al_mobdea/features/notifications/domain/use_cases/show_local_notification_use_case.dart';
import 'package:al_mobdea/features/notifications/domain/use_cases/stream_foreground_notifications_use_case.dart';
import 'package:al_mobdea/features/notifications/domain/use_cases/stream_opened_notifications_use_case.dart';
import 'package:al_mobdea/features/notifications/domain/use_cases/sync_notification_grade_topic_use_case.dart';
import 'package:al_mobdea/features/notifications/domain/use_cases/unsubscribe_notification_grade_topic_use_case.dart';
import 'package:al_mobdea/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:al_mobdea/features/notifications/presentation/cubit/notification_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockInitializeNotificationsUseCase extends Mock
    implements InitializeNotificationsUseCase {}

class MockSyncNotificationGradeTopicUseCase extends Mock
    implements SyncNotificationGradeTopicUseCase {}

class MockUnsubscribeNotificationGradeTopicUseCase extends Mock
    implements UnsubscribeNotificationGradeTopicUseCase {}

class MockStreamForegroundNotificationsUseCase extends Mock
    implements StreamForegroundNotificationsUseCase {}

class MockStreamOpenedNotificationsUseCase extends Mock
    implements StreamOpenedNotificationsUseCase {}

class MockGetInitialNotificationUseCase extends Mock
    implements GetInitialNotificationUseCase {}

class MockShowLocalNotificationUseCase extends Mock
    implements ShowLocalNotificationUseCase {}

void main() {
  const failure = AppErrorModel(
    code: 'unavailable',
    message: 'تعذر تهيئة الإشعارات، حاول مرة أخرى.',
    type: AppErrorType.network,
    isRetryable: true,
  );

  late MockInitializeNotificationsUseCase initializeNotificationsUseCase;
  late MockSyncNotificationGradeTopicUseCase syncNotificationGradeTopicUseCase;
  late MockUnsubscribeNotificationGradeTopicUseCase
  unsubscribeNotificationGradeTopicUseCase;
  late MockStreamForegroundNotificationsUseCase
  streamForegroundNotificationsUseCase;
  late MockStreamOpenedNotificationsUseCase streamOpenedNotificationsUseCase;
  late MockGetInitialNotificationUseCase getInitialNotificationUseCase;
  late MockShowLocalNotificationUseCase showLocalNotificationUseCase;

  setUp(() {
    initializeNotificationsUseCase = MockInitializeNotificationsUseCase();
    syncNotificationGradeTopicUseCase = MockSyncNotificationGradeTopicUseCase();
    unsubscribeNotificationGradeTopicUseCase =
        MockUnsubscribeNotificationGradeTopicUseCase();
    streamForegroundNotificationsUseCase =
        MockStreamForegroundNotificationsUseCase();
    streamOpenedNotificationsUseCase = MockStreamOpenedNotificationsUseCase();
    getInitialNotificationUseCase = MockGetInitialNotificationUseCase();
    showLocalNotificationUseCase = MockShowLocalNotificationUseCase();
  });

  NotificationCubit buildCubit() {
    return NotificationCubit(
      initializeNotificationsUseCase: initializeNotificationsUseCase,
      syncNotificationGradeTopicUseCase: syncNotificationGradeTopicUseCase,
      unsubscribeNotificationGradeTopicUseCase:
          unsubscribeNotificationGradeTopicUseCase,
      streamForegroundNotificationsUseCase:
          streamForegroundNotificationsUseCase,
      streamOpenedNotificationsUseCase: streamOpenedNotificationsUseCase,
      getInitialNotificationUseCase: getInitialNotificationUseCase,
      showLocalNotificationUseCase: showLocalNotificationUseCase,
    );
  }

  blocTest<NotificationCubit, NotificationState>(
    'emits [NotificationLoading, NotificationReady] on initialization',
    build: () {
      when(() => initializeNotificationsUseCase())
          .thenAnswer((_) async => Right<AppErrorModel, void>(null));
      when(() => streamForegroundNotificationsUseCase())
          .thenAnswer((_) => Stream.empty());
      when(() => streamOpenedNotificationsUseCase())
          .thenAnswer((_) => Stream.empty());
      when(() => getInitialNotificationUseCase()).thenAnswer(
        (_) async => Right<AppErrorModel, AppNotificationEntity?>(null),
      );

      return buildCubit();
    },
    act: (cubit) => cubit.initialize(),
    expect: () => [isA<NotificationLoading>(), isA<NotificationReady>()],
    verify: (_) {
      verify(() => initializeNotificationsUseCase()).called(1);
      verify(() => streamForegroundNotificationsUseCase()).called(1);
      verify(() => streamOpenedNotificationsUseCase()).called(1);
      verify(() => getInitialNotificationUseCase()).called(1);
    },
  );

  blocTest<NotificationCubit, NotificationState>(
    'emits [NotificationLoading, NotificationFailure] when initialization fails',
    build: () {
      when(() => initializeNotificationsUseCase())
          .thenAnswer((_) async => Left<AppErrorModel, void>(failure));

      return buildCubit();
    },
    act: (cubit) => cubit.initialize(),
    expect: () => [
      isA<NotificationLoading>(),
      isA<NotificationFailure>().having(
        (state) => state.error,
        'error',
        same(failure),
      ),
    ],
    verify: (_) {
      verify(() => initializeNotificationsUseCase()).called(1);
      verifyNever(() => streamForegroundNotificationsUseCase());
      verifyNever(() => streamOpenedNotificationsUseCase());
      verifyNever(() => getInitialNotificationUseCase());
    },
  );
}
