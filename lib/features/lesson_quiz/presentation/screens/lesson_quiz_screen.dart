import 'package:al_mobdea/app/dependency_injection/service_locator.dart';
import 'package:al_mobdea/core/helper/app_system_ui.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/features/lesson_quiz/presentation/cubit/lesson_quiz_cubit.dart';
import 'package:al_mobdea/features/lesson_quiz/presentation/widgets/lesson_quiz_screen_widgets/lesson_quiz_question_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LessonQuizScreen extends StatelessWidget {
  const LessonQuizScreen({super.key, required this.lessonId});

  final String lessonId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return getIt<LessonQuizCubit>()..loadLessonQuiz(lessonId: lessonId);
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppSystemUi.dark(),
        child: Scaffold(
          backgroundColor: ColorPalette.background,
          body: LessonQuizQuestionScreenContent(lessonId: lessonId),
        ),
      ),
    );
  }
}
