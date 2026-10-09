import 'package:al_mobdea/app/dependency_injection/service_locator.dart';
import 'package:al_mobdea/core/helper/app_system_ui.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/features/study_notes/presentation/cubit/study_notes_cubit.dart';
import 'package:al_mobdea/features/study_notes/presentation/widgets/study_notes_screen_widgets/study_notes_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudyNotesScreen extends StatelessWidget {
  const StudyNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StudyNotesCubit>(
      create: (_) => getIt<StudyNotesCubit>()..initialize(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppSystemUi.dark(),
        child: const Scaffold(
          backgroundColor: ColorPalette.background,
          body: StudyNotesScreenContent(),
        ),
      ),
    );
  }
}
