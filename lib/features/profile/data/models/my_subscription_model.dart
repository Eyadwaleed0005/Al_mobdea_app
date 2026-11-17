import 'package:al_mobdea/core/firebase/firestore/firestore_fields.dart';
import 'package:al_mobdea/features/profile/domain/entities/my_subscription_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MySubscriptionModel extends MySubscriptionEntity {
  const MySubscriptionModel({
    required super.isActive,
    super.subscriptionStartAt,
    super.subscriptionEndAt,
  });

  factory MySubscriptionModel.fromFirestore(Map<String, dynamic> data) {
    return MySubscriptionModel(
      isActive: data[FirestoreFields.isActive] as bool? ?? false,
      subscriptionStartAt: _readDateTime(
        data[FirestoreFields.subscriptionStartAt],
      ),
      subscriptionEndAt: _readDateTime(data[FirestoreFields.subscriptionEndAt]),
    );
  }

  MySubscriptionEntity toEntity() {
    return MySubscriptionEntity(
      isActive: isActive,
      subscriptionStartAt: subscriptionStartAt,
      subscriptionEndAt: subscriptionEndAt,
    );
  }

  static DateTime? _readDateTime(Object? value) {
    if (value is Timestamp) {
      return value.toDate().toUtc();
    }

    if (value is DateTime) {
      return value.toUtc();
    }

    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value, isUtc: true);
    }

    if (value is num) {
      return DateTime.fromMillisecondsSinceEpoch(value.toInt(), isUtc: true);
    }

    if (value is String) {
      return DateTime.tryParse(value)?.toUtc();
    }

    return null;
  }
}
