import 'package:al_mobdea/core/helper/arabic_numbers_helper.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/features/exams/presentation/widgets/start_exam_widgets/start_exam_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartExamProgressHeader extends StatelessWidget {
  const StartExamProgressHeader({
    super.key,
    required this.currentQuestion,
    required this.totalQuestions,
    required this.completionPercentage,
    required this.remainingDuration,
  });

  final int currentQuestion;
  final int totalQuestions;
  final int completionPercentage;
  final Duration remainingDuration;

  @override
  Widget build(BuildContext context) {
    final double progressValue = totalQuestions > 0
        ? (currentQuestion / totalQuestions).clamp(0.0, 1.0).toDouble()
        : 0;

    final int normalizedPercentage = completionPercentage.clamp(0, 100);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            StartExamTimer(remainingDuration: remainingDuration),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'السؤال ${toArabicNumbers(currentQuestion)} من ${toArabicNumbers(totalQuestions)}',
                  textDirection: TextDirection.rtl,
                  style: AppTextStyle.font14TextPrimaryBoldTajawal(),
                ),
                verticalSpace(4),
                Text(
                  '%${toArabicNumbers(normalizedPercentage)} مكتمل',
                  textDirection: TextDirection.rtl,
                  style: AppTextStyle.font12TextSecondaryRegularTajawal(),
                ),
              ],
            ),
          ],
        ),
        verticalSpace(10),
        // Fills from the right side (RTL).
        Directionality(
          textDirection: TextDirection.rtl,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4.r),
            child: LinearProgressIndicator(
              value: progressValue,
              minHeight: 8.h,
              backgroundColor: ColorPalette.wine100.withValues(alpha: 0.5),
              valueColor: const AlwaysStoppedAnimation<Color>(
                ColorPalette.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
