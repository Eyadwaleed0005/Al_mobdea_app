import 'package:al_mobdea/core/widgets/curved_app_bar.dart';
import 'package:flutter/material.dart';

class LessonQuizAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LessonQuizAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.showBackButton = true,
  });

  final String title;
  final VoidCallback? onBack;
  final bool showBackButton;

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return CurvedAppBar(
      title: title,
      onBack: onBack,
      showBackButton: showBackButton,
    );
  }
}
