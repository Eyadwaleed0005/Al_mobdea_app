import 'package:al_mobdea/features/main_navigation/data/data_sources/remote/student_grade_remote_data_source.dart';

/// Supplies a sample grade while Firebase is not initialized, so the student
/// navigation UI can be previewed without a Firebase project.
/// remove this file when firebase is initialized
class PreviewStudentGradeRemoteDataSource implements StudentGradeRemoteDataSource {
  const PreviewStudentGradeRemoteDataSource();

  static const String previewGradeId = 'preview-grade';

  @override
  Stream<String> streamGradeId() => Stream<String>.value(previewGradeId);
}
