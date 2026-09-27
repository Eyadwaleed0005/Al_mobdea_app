import 'package:al_mobdea/features/live_session/domain/entity/meeting_type.dart';

class LiveSessionEntity {
  const LiveSessionEntity({
    required this.gradeId,
    required this.platformType,
    required this.meetingUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  final String gradeId;
  final String platformType;
  final String meetingUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  MeetingType? get meetingType => MeetingType.fromPlatformType(platformType);
}
