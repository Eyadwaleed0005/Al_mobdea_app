import 'package:al_mobdea/core/widgets/background/background_student_layout.dart';
import 'package:flutter/material.dart';

class ProfileBackground extends StatelessWidget {
  final Widget child;

  const ProfileBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BackgroundStudentLayout(child: child);
  }
}
