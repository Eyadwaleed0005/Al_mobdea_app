import 'package:flutter/material.dart';

class BackgroundStudentLayout extends StatelessWidget {
  const BackgroundStudentLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFEF9F2), Color(0xFFFDF4E9), Color(0xFFFFFCF7)],
              stops: [0, 0.5, 1],
            ),
          ),
        ),
        child,
      ],
    );
  }
}
