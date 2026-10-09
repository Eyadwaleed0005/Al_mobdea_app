import 'package:al_mobdea/core/firebase/firestore/firestore_fields.dart';
import 'package:al_mobdea/features/authentication/domain/entity/student_entity.dart';

class StudentModel extends StudentEntity {
  const StudentModel({required super.id, required super.email});

  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map[FirestoreFields.studentId] ?? '',
      email: map[FirestoreFields.email] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      FirestoreFields.studentId: id,
      FirestoreFields.email: email,
    };
  }
}
