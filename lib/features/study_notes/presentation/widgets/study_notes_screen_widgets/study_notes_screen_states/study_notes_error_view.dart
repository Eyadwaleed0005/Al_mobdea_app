import 'package:al_mobdea/core/widgets/app_error_state.dart';
import 'package:flutter/material.dart';

class StudyNotesErrorView extends StatelessWidget {
  const StudyNotesErrorView({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  final String errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return AppErrorState(message: errorMessage, onRetry: onRetry);
  }
}
