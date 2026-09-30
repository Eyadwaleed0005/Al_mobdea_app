import 'package:al_mobdea/features/notifications/data/models/app_notification_model.dart';

abstract interface class NotificationRemoteDataSource {
  Future<void> requestPermission();

  Future<void> subscribeToGradeTopic({required String gradeId});

  Future<void> unsubscribeFromGradeTopic({required String gradeId});

  Stream<AppNotificationModel> streamForegroundNotifications();

  Stream<AppNotificationModel> streamOpenedNotifications();

  Future<AppNotificationModel?> getInitialNotification();
}
