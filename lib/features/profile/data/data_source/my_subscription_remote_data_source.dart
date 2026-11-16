import 'package:al_mobdea/features/profile/data/models/my_subscription_model.dart';

abstract interface class MySubscriptionRemoteDataSource {
  Stream<MySubscriptionModel> streamMySubscription();
}
