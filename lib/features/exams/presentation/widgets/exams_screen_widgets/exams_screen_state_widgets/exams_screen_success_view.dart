import 'package:al_mobdea/features/exams/domain/entities/student_exam_list_item_entity.dart';
import 'package:al_mobdea/features/exams/presentation/widgets/exams_screen_widgets/available_exams_list_view.dart';
import 'package:flutter/material.dart';

class ExamsScreenSuccessView extends StatelessWidget {
  const ExamsScreenSuccessView({
    super.key,
    required this.exams,
    required this.onExamPressed,
    this.openingExamId,
  });

  final List<StudentExamListItemEntity> exams;
  final ValueChanged<StudentExamListItemEntity> onExamPressed;
  final String? openingExamId;

  @override
  Widget build(BuildContext context) {
    return AvailableExamsListView(
      exams: exams,
      openingExamId: openingExamId,
      onExamPressed: onExamPressed,
    );
  }
}
