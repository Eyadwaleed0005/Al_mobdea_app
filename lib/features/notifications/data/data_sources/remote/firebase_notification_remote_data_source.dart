import 'package:al_mobdea/features/notifications/data/data_sources/remote/notification_remote_data_source.dart';
import 'package:al_mobdea/features/notifications/data/models/app_notification_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FirebaseNotificationRemoteDataSource
    implements NotificationRemoteDataSource {
  const FirebaseNotificationRemoteDataSource({
    required FirebaseMessaging firebaseMessaging,
  }) : _firebaseMessaging = firebaseMessaging;

  final FirebaseMessaging _firebaseMessaging;

  static const String _gradeTopicPrefix = 'grade_';

  @override
  Future<void> requestPermission() async {
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    debugPrint(
      '[Notifications] Permission: ${settings.authorizationStatus.name}',
    );

    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: false,
      badge: false,
      sound: false,
    );
  }

  @override
  Future<void> subscribeToGradeTopic({required String gradeId}) async {
    final topic = _createGradeTopic(gradeId);

    debugPrint('[Notifications] Subscribing to topic: $topic');

    await _firebaseMessaging.subscribeToTopic(topic);

    debugPrint('[Notifications] Topic subscription completed: $topic');
  }

  @override
  Future<void> unsubscribeFromGradeTopic({required String gradeId}) {
    return _firebaseMessaging.unsubscribeFromTopic(_createGradeTopic(gradeId));
  }

  @override
  Stream<AppNotificationModel> streamForegroundNotifications() {
    debugPrint('[Notifications] Foreground listener started');

    return FirebaseMessaging.onMessage.map((message) {
      debugPrint(
        '[Notifications] Foreground message received: ${message.messageId}',
      );

      return AppNotificationModel.fromRemoteMessage(message);
    });
  }

  @override
  Stream<AppNotificationModel> streamOpenedNotifications() {
    return FirebaseMessaging.onMessageOpenedApp.map(
      AppNotificationModel.fromRemoteMessage,
    );
  }

  @override
  Future<AppNotificationModel?> getInitialNotification() async {
    final message = await _firebaseMessaging.getInitialMessage();

    if (message == null) {
      return null;
    }

    return AppNotificationModel.fromRemoteMessage(message);
  }

  String _createGradeTopic(String gradeId) {
    final normalizedGradeId = gradeId.trim();

    if (normalizedGradeId.isEmpty) {
      throw const FormatException();
    }

    final isValidTopic = RegExp(r'^[a-zA-Z0-9_.~%-]+$')
        .hasMatch(normalizedGradeId);

    if (!isValidTopic) {
      throw const FormatException();
    }

    return '$_gradeTopicPrefix$normalizedGradeId';
  }
}
