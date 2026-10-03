import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/notifications/domain/entities/app_notification_entity.dart';
import 'package:al_mobdea/features/notifications/domain/repositories/notification_repository.dart';
import 'package:dartz/dartz.dart';

class StreamOpenedNotificationsUseCase {
  final NotificationRepository _repository;

  const StreamOpenedNotificationsUseCase({required NotificationRepository repository})
    : _repository = repository;

  Stream<Either<AppErrorModel, AppNotificationEntity>> call() {
    return _repository.streamOpenedNotifications();
  }
}
