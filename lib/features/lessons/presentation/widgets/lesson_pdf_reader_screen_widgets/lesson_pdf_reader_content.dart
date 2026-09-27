import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/widgets/background/background_student_layout.dart';
import 'package:al_mobdea/features/lessons/domain/entities/lesson_entity.dart';
import 'package:al_mobdea/features/lessons/presentation/widgets/lesson_pdf_reader_screen_widgets/lesson_pdf_body.dart';
import 'package:al_mobdea/features/lessons/presentation/widgets/lesson_pdf_reader_screen_widgets/lesson_pdf_reader_header.dart';
import 'package:flutter/material.dart';

class LessonPdfReaderContent extends StatelessWidget {
  const LessonPdfReaderContent({super.key, required this.lesson});

  final LessonEntity lesson;

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.orientationOf(context) == Orientation.landscape;

    return Scaffold(
      backgroundColor: ColorPalette.background,
      appBar: LessonPdfReaderHeader(
        lessonTitle: lesson.title,
        isLandscape: isLandscape,
      ),
      body: BackgroundStudentLayout(child: LessonPdfBody(lesson: lesson)),
    );
  }
}
