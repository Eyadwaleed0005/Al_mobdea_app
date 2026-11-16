import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/profile/domain/entities/my_subscription_entity.dart';
import 'package:dartz/dartz.dart';

abstract interface class MySubscriptionRepository {
  Stream<Either<AppErrorModel, MySubscriptionEntity>> streamMySubscription();
}
