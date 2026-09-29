import 'package:al_mobdea/features/lesson_quiz/data/models/lesson_quiz_question_model.dart';

abstract class LessonQuizRemoteDataSource {
  Future<List<LessonQuizQuestionModel>> getQuizQuestions({
    required String lessonId,
  });
}
