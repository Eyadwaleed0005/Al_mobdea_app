import 'package:al_mobdea/app/routes/screen_routes/route_names.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/features/lesson_quiz/presentation/screens/lesson_quiz_screen.dart';
import 'package:al_mobdea/features/lessons/domain/entities/lesson_entity.dart';
import 'package:al_mobdea/features/lessons/presentation/screens/lesson_details_screen.dart';
import 'package:al_mobdea/features/lessons/presentation/screens/lesson_pdf_reader_screen.dart';
import 'package:al_mobdea/features/lessons/presentation/screens/lessons_screen.dart';
import 'package:flutter/material.dart';

abstract final class LessonsRoutes {
  const LessonsRoutes._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.lessons:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const LessonsScreen(),
        );
      case RouteNames.lessonDetails:
        final lesson = settings.arguments;
        if (lesson is! LessonEntity) return _invalidRoute(settings);
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => LessonDetailsScreen(lesson: lesson),
        );
      case RouteNames.lessonDetailsPdf:
        final lesson = settings.arguments;
        if (lesson is! LessonEntity) return _invalidRoute(settings);
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => LessonPdfReaderScreen(lesson: lesson),
        );
      case RouteNames.lessonQuiz:
        final lessonId = settings.arguments;
        if (lessonId is! String || lessonId.trim().isEmpty) {
          return _invalidRoute(settings);
        }
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => LessonQuizScreen(lessonId: lessonId),
        );
      default:
        return null;
    }
  }

  static Route<void> _invalidRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => Scaffold(
        body: Center(
          child: Text(
            'تعذر فتح الدرس',
            textDirection: TextDirection.rtl,
            style: AppTextStyle.font20TextPrimarySemiBoldKufam(),
          ),
        ),
      ),
    );
  }
}
