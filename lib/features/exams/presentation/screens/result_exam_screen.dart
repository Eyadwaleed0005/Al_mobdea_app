import 'package:al_mobdea/core/helper/app_system_ui.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/features/exams/domain/entities/student_exam_result_entity.dart';
import 'package:al_mobdea/features/exams/presentation/widgets/result_exam_widgets/result_exam_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResultExamScreen extends StatelessWidget {
  const ResultExamScreen({super.key, required this.result});

  final StudentExamResultEntity result;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.dark(),
      child: Scaffold(
        backgroundColor: ColorPalette.background,

        body: ResultExamScreenContent(result: result),
      ),
    );
  }
}
