import 'package:al_mobdea/app/dependency_injection/service_locator.dart';
import 'package:al_mobdea/core/helper/app_system_ui.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/features/lessons/presentation/cubit/lessons_cubit.dart';
import 'package:al_mobdea/features/lessons/presentation/widgets/lesson_screen_widgets/lessons_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LessonsScreen extends StatelessWidget {
  const LessonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LessonsCubit>()..initialize(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppSystemUi.dark(),
        child: const Scaffold(
          backgroundColor: ColorPalette.background,
          body: LessonsScreenContent(),
        ),
      ),
    );
  }
}
