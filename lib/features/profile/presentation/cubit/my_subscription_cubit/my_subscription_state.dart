import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/profile/domain/entities/my_subscription_entity.dart';

sealed class MySubscriptionState {
  const MySubscriptionState();
}

final class MySubscriptionInitial extends MySubscriptionState {
  const MySubscriptionInitial();
}

final class MySubscriptionLoading extends MySubscriptionState {
  const MySubscriptionLoading();
}

final class MySubscriptionSuccess extends MySubscriptionState {
  const MySubscriptionSuccess({required this.subscription});

  final MySubscriptionEntity subscription;
}

final class MySubscriptionFailure extends MySubscriptionState {
  const MySubscriptionFailure({required this.error});

  final AppErrorModel error;
}
