import 'package:al_mobdea/features/lessons/data/models/lesson_model.dart';

abstract interface class LessonsRemoteDataSource {
  Stream<List<LessonModel>> streamLessons({required String gradeId});

  Future<LessonModel> getLessonById({
    required String lessonId,
    required String gradeId,
  });
}
