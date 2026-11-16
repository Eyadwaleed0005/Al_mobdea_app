import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';

class LoginBackground extends StatelessWidget {
  final Widget child;

  const LoginBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: 0,
          left: 0,
          width: screenSize.width,
          height: screenSize.height,
          child: const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 0.35, 0.65, 1.0],
                colors: [
                  Color(0xFFFAF3EE),
                  Color(0xFFE8D0CA),
                  ColorPalette.primary,
                  ColorPalette.deepSurface,
                ],
              ),
            ),
            child: IgnorePointer(child: CustomPaint(painter: _MobdeaBackgroundPainter())),
          ),
        ),
        SafeArea(child: child),
      ],
    );
  }
}

class _MobdeaBackgroundPainter extends CustomPainter {
  const _MobdeaBackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    _drawArabicLetter(
      canvas: canvas,
      letter: 'ـبـ',
      offset: Offset(size.width * 0.08, size.height * 0.32),
      fontSize: 34,
      color: const Color(0xFF4A0719).withValues(alpha: 0.16),
      rotation: 0.08,
    );

    _drawArabicLetter(
      canvas: canvas,
      letter: 'هـ',
      offset: Offset(size.width * 0.82, size.height * 0.88),
      fontSize: 140,
      color: Colors.white.withValues(alpha: 0.11),
      rotation: -0.25,
    );

    _drawArabicLetter(
      canvas: canvas,
      letter: 'ـم',
      offset: Offset(size.width * 0.22, size.height * 0.92),
      fontSize: 155,
      color: Colors.white.withValues(alpha: 0.11),
      rotation: 0.38,
    );
  }

  void _drawArabicLetter({
    required Canvas canvas,
    required String letter,
    required Offset offset,
    required double fontSize,
    required Color color,
    double rotation = 0,
  }) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: letter,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          fontFamily: AppTextStyle.kufam,
          color: color,
        ),
      ),
      textDirection: TextDirection.rtl,
    )..layout();

    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    canvas.rotate(rotation);
    textPainter.paint(canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
