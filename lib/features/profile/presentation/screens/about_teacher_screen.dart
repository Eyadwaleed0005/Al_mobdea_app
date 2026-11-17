import 'package:al_mobdea/core/helper/app_system_ui.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/features/profile/presentation/widgets/about_teacher_widgets/about_teacher_screen_content.dart';
import 'package:al_mobdea/features/profile/presentation/widgets/profile_screen_widgets/profile_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutTeacherScreen extends StatelessWidget {
  const AboutTeacherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.dark(),
      child: Scaffold(
        extendBody: true,
        backgroundColor: ColorPalette.background,
        body: ProfileBackground(
          child: SafeArea(
            bottom: false,
            child: const AboutTeacherScreenContent(),
          ),
        ),
      ),
    );
  }
}
