import 'dart:math';

import 'package:al_mobdea/core/helper/arabic_numbers_helper.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/features/lesson_quiz/domain/entity/lesson_quiz_result_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizResultCard extends StatelessWidget {
  const QuizResultCard({
    super.key,
    required this.result,
  });

  final LessonQuizResultEntity result;

  @override
  Widget build(BuildContext context) {
    final resultColor =
        result.isPassing ? ColorPalette.primary : ColorPalette.error;

    return Column(
      children: [
        SizedBox(
          width: 210.w,
          height: 210.w,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorPalette.primarySoftBackground,
                ),
              ),
              Center(
                child: SizedBox(
                  width: 160.w,
                  height: 160.w,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorPalette.surface,
                        ),
                      ),
                      CustomPaint(
                        painter: _RingGaugePainter(
                          percentage: result.percentage,
                          trackColor: ColorPalette.wine100.withValues(
                            alpha: 0.35,
                          ),
                          progressColor: resultColor,
                          strokeWidth: 8.w,
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${toArabicNumbers(
                                (result.percentage * 100).round(),
                              )}%',
                              style: AppTextStyle.font24PrimaryBoldKufam()
                                  .copyWith(fontSize: 36.sp),
                              textDirection: TextDirection.ltr,
                            ),
                            verticalSpace(6),
                            Text(
                              '${toArabicNumbers(result.earnedScore)} / '
                              '${toArabicNumbers(result.totalScore)}',
                              style: AppTextStyle
                                  .font16TextPrimaryMediumTajawal(),
                              textDirection: TextDirection.ltr,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        verticalSpace(20),
        Text(
          _getSummaryText(
            correctAnswers: result.correctAnswersCount,
            totalQuestions: result.totalQuestions,
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: AppTextStyle.font14TextSecondaryRegularTajawal(),
        ),
      ],
    );
  }

  String _getSummaryText({
    required int correctAnswers,
    required int totalQuestions,
  }) {
    final totalText = _getQuestionsCountText(totalQuestions);

    if (correctAnswers == 1) {
      return 'إجابة صحيحة واحدة من أصل $totalText';
    }

    if (correctAnswers == 2) {
      return 'إجابتان صحيحتان من أصل $totalText';
    }

    return '${toArabicNumbers(correctAnswers)} إجابات صحيحة '
        'من أصل $totalText';
  }

  String _getQuestionsCountText(int totalQuestions) {
    if (totalQuestions == 1) {
      return 'سؤال واحد';
    }

    if (totalQuestions == 2) {
      return 'سؤالين';
    }

    return '${toArabicNumbers(totalQuestions)} أسئلة';
  }
}

class _RingGaugePainter extends CustomPainter {
  const _RingGaugePainter({
    required this.percentage,
    required this.trackColor,
    required this.progressColor,
    required this.strokeWidth,
  });

  final double percentage;
  final Color trackColor;
  final Color progressColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final safePercentage = percentage.clamp(0.0, 1.0).toDouble();

    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final diameter = min(
      size.width,
      size.height,
    );

    final radius = max(
      0.0,
      (diameter - strokeWidth) / 2,
    );

    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = progressColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(
      center,
      radius,
      trackPaint,
    );

    final sweepAngle = 2 * pi * safePercentage;

    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      -pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingGaugePainter oldDelegate) {
    return oldDelegate.percentage != percentage ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
