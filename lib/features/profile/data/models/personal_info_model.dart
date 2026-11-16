import 'package:al_mobdea/core/firebase/firestore/firestore_fields.dart';
import 'package:al_mobdea/features/profile/domain/entities/personal_info_entity.dart';

class PersonalInfoModel extends PersonalInfoEntity {
  const PersonalInfoModel({
    required super.studentId,
    required super.name,
    required super.phoneNumber,
    required super.email,
  });

  factory PersonalInfoModel.fromFirestore({
    required String studentId,
    required Map<String, dynamic> data,
  }) {
    return PersonalInfoModel(
      studentId: studentId,
      name: _readRequiredString(data[FirestoreFields.name]),
      phoneNumber: _readRequiredString(data[FirestoreFields.phoneNumber]),
      email: _readRequiredString(data[FirestoreFields.email]),
    );
  }

  PersonalInfoEntity toEntity() {
    return PersonalInfoEntity(
      studentId: studentId,
      name: name,
      phoneNumber: phoneNumber,
      email: email,
    );
  }

  static String _readRequiredString(Object? value) {
    if (value is! String || value.trim().isEmpty) {
      throw const FormatException();
    }

    return value.trim();
  }
}
