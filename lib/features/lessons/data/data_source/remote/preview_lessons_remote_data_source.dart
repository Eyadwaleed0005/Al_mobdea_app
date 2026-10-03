import 'package:al_mobdea/features/lessons/data/data_source/remote/lessons_remote_data_source.dart';
import 'package:al_mobdea/features/lessons/data/models/lesson_model.dart';

//! TODO: remove this file when firebase is initialized and start using [FirebaseLessonsRemoteDataSource]
class PreviewLessonsRemoteDataSource implements LessonsRemoteDataSource {
  const PreviewLessonsRemoteDataSource();

  static const List<LessonModel> _lessons = [
    LessonModel(
      lessonId: 'preview-intro-lesson',
      title: 'المبتدأ والخبر',
      description: 'علامات الرفع والإعراب',
      gradeId: 'preview-grade',
      isPublished: true,
      youtubeUrl: 'https://www.youtube.com/watch?v=9Ys_NY0G_Ww&list=RD9Ys_NY0G_Ww&start_radio=1&pp=ygUHbGVnZSBjeaAHAQ%3D%3D',
      pdfStoragePath: 'https://drive.google.com/file/d/1-FruhI5qRGRfwByS_UHbxbm-gwfK0hvE/view',
      pdfFileName: 'Mahmoud_Elnagar_CV',
      pdfFileSize: 0,
    ),
    LessonModel(
      lessonId: 'preview-nahw-lesson',
      title: 'النحو العربي',
      description: 'الجملة الاسمية وأركانها',
      gradeId: 'preview-grade',
      isPublished: true,
      youtubeUrl: 'https://www.youtube.com/watch?v=9Ys_NY0G_Ww&list=RD9Ys_NY0G_Ww&start_radio=1&pp=ygUHbGVnZSBjeaAHAQ%3D%3D',
      pdfStoragePath: 'https://drive.google.com/file/d/1-FruhI5qRGRfwByS_UHbxbm-gwfK0hvE/view',
      pdfFileName: '',
      pdfFileSize: 0,
    ),
  ];

  @override
  Stream<List<LessonModel>> streamLessons({required String gradeId}) => Stream.value(_lessons);

  @override
  Future<LessonModel> getLessonById({required String lessonId, required String gradeId}) async =>
      _lessons.firstWhere((lesson) => lesson.lessonId == lessonId);
}
