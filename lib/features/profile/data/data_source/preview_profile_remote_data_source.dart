import 'package:al_mobdea/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:al_mobdea/features/profile/data/models/profile_model.dart';

/// Supplies a sample profile while Firebase is not initialized, so the
/// profile screen can be previewed without a Firebase project.
/// remove this file when firebase is initialized
class PreviewProfileRemoteDataSource implements ProfileRemoteDataSource {
  const PreviewProfileRemoteDataSource();

  static final Map<String, dynamic> _previewStudentData = <String, dynamic>{
    FirestoreStudentFields.name: 'محمد جلال عبد الفتاح',
    FirestoreStudentFields.gradeId: 'secondary_3',
    FirestoreStudentFields.email: 'galal@elmobde3.com',
    FirestoreStudentFields.subscriptionStartAt:
        DateTime.utc(2026, 7, 18).millisecondsSinceEpoch,
    FirestoreStudentFields.subscriptionEndAt:
        DateTime.utc(2026, 10, 18).millisecondsSinceEpoch,
  };

  static final Map<String, dynamic> _previewGradeData = <String, dynamic>{
    FirestoreGradeFields.name: 'الصف الثالث الثانوي',
  };

  @override
  Stream<ProfileModel> streamStudentProfile() {
    return Stream<ProfileModel>.value(
      ProfileModel.fromFirestore(
        studentData: _previewStudentData,
        gradeData: _previewGradeData,
      ),
    );
  }
}

// Local aliases to keep the preview decoupled from Firestore field names.
abstract final class FirestoreStudentFields {
  static const String name = 'name';
  static const String gradeId = 'gradeId';
  static const String email = 'email';
  static const String subscriptionStartAt = 'subscriptionStartAt';
  static const String subscriptionEndAt = 'subscriptionEndAt';
}

abstract final class FirestoreGradeFields {
  static const String name = 'name';
}
