import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/notifications/domain/entities/app_notification_entity.dart';

sealed class NotificationState {
  const NotificationState();
}

final class NotificationInitial extends NotificationState {
  const NotificationInitial();
}

final class NotificationLoading extends NotificationState {
  const NotificationLoading();
}

final class NotificationReady extends NotificationState {
  const NotificationReady();
}

final class NotificationNavigationRequested extends NotificationState {
  final AppNotificationEntity notification;

  const NotificationNavigationRequested({required this.notification});
}

final class NotificationFailure extends NotificationState {
  final AppErrorModel error;

  const NotificationFailure({required this.error});
}
