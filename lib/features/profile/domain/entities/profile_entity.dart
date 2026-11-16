class ProfileEntity {
  const ProfileEntity({required this.studentProfile, required this.grade});

  final StudentProfileEntity studentProfile;
  final GradeEntity grade;
}

class StudentProfileEntity {
  const StudentProfileEntity({
    required this.name,
    required this.gradeId,
    required this.email,
  });

  final String name;
  final String gradeId;
  final String email;
}

class GradeEntity {
  const GradeEntity({required this.name});

  final String name;
}
