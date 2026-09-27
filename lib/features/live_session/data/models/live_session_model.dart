import 'package:al_mobdea/core/firebase/firestore/firestore_fields.dart';
import 'package:al_mobdea/features/live_session/domain/entity/live_session_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LiveSessionModel extends LiveSessionEntity {
  const LiveSessionModel({
    required super.gradeId,
    required super.platformType,
    required super.meetingUrl,
    required super.createdAt,
    required super.updatedAt,
  });

  factory LiveSessionModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    final data = document.data() ?? <String, dynamic>{};

    return LiveSessionModel(
      gradeId: document.id,
      platformType: data[FirestoreFields.platformType] as String? ?? '',
      meetingUrl: data[FirestoreFields.meetingUrl] as String? ?? '',
      createdAt:
          (data[FirestoreFields.createdAt] as Timestamp?)?.toDate() ??
          DateTime.now(),
      updatedAt:
          (data[FirestoreFields.updatedAt] as Timestamp?)?.toDate() ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      FirestoreFields.platformType: platformType,
      FirestoreFields.meetingUrl: meetingUrl,
      FirestoreFields.createdAt: Timestamp.fromDate(createdAt),
      FirestoreFields.updatedAt: Timestamp.fromDate(updatedAt),
    };
  }
}
