class MySubscriptionEntity {
  const MySubscriptionEntity({
    required this.isActive,
    this.subscriptionStartAt,
    this.subscriptionEndAt,
  });

  final bool isActive;
  final DateTime? subscriptionStartAt;
  final DateTime? subscriptionEndAt;
}
