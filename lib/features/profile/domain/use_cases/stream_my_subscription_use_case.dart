import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/profile/domain/entities/my_subscription_entity.dart';
import 'package:al_mobdea/features/profile/domain/repositories/my_subscription_repository.dart';
import 'package:dartz/dartz.dart';

class StreamMySubscriptionUseCase {
  const StreamMySubscriptionUseCase({
    required MySubscriptionRepository repository,
  }) : _repository = repository;

  final MySubscriptionRepository _repository;

  Stream<Either<AppErrorModel, MySubscriptionEntity>> call() {
    return _repository.streamMySubscription();
  }
}
