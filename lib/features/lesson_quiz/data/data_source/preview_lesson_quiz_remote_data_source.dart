//! TODO: remove this file when firebase is initialized and start using
//! [FirebaseLessonQuizRemoteDataSource]
import 'package:al_mobdea/features/lesson_quiz/data/data_source/lesson_quiz_remote_data_source.dart';
import 'package:al_mobdea/features/lesson_quiz/data/models/lesson_quiz_question_model.dart';

class PreviewLessonQuizRemoteDataSource implements LessonQuizRemoteDataSource {
  PreviewLessonQuizRemoteDataSource();

  @override
  Future<List<LessonQuizQuestionModel>> getQuizQuestions({required String lessonId}) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));

    return _questions;
  }

  List<LessonQuizQuestionModel> get _questions {
    return const [
      LessonQuizQuestionModel(
        questionId: 'preview-quiz-question-1',
        questionText: 'ما إعراب كلمة «الطالب» في الجملة؟',
        options: ['فعل', 'مبتدأ', 'حرف', 'خبر'],
        correctOptionIndex: 1,
        score: 1,
      ),
      LessonQuizQuestionModel(
        questionId: 'preview-quiz-question-2',
        questionText: 'ما علامة رفع المبتدأ المقدَّم؟',
        options: ['الفتحة', 'الكسرة', 'الألف', 'الضمة'],
        correctOptionIndex: 3,
        score: 1,
      ),
    ];
  }
}
