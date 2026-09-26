import 'package:al_mobdea/core/firebase/firestore/firestore_fields.dart';
import 'package:al_mobdea/features/authentication/domain/entity/login_entity.dart';

class LoginModel extends LoginEntity {
  final String id;

  LoginModel({required this.id, required super.email});

  Map<String, dynamic> toMap() {
    return {FirestoreFields.studentId: id, FirestoreFields.email: email};
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      id: map[FirestoreFields.studentId] ?? '',
      email: map[FirestoreFields.email] ?? '',
    );
  }
}
