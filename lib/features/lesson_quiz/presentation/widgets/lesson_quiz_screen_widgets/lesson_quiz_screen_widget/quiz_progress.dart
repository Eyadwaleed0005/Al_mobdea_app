import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/features/lesson_quiz/presentation/widgets/lesson_quiz_screen_widgets/lesson_quiz_screen_widget/quiz_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizProgress extends StatelessWidget {
  const QuizProgress({
    super.key,
    required this.current,
    required this.total,
    this.totalScore,
    this.completionPercentage,
    this.statusText,
    this.statusColor,
  });

  final int current;
  final int total;
  final int? totalScore;

  final int? completionPercentage;
  final String? statusText;
  final Color? statusColor;

  @override
  Widget build(BuildContext context) {
    final progress = total == 0 ? 0.0 : (current / total).clamp(0.0, 1.0);

    final percentage = completionPercentage ?? (progress * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        QuizHeader(current: current, total: total, totalScore: totalScore),
        verticalSpace(2),
        Align(
          alignment: Alignment.centerLeft,
          child: statusText != null
              ? Text(
                  statusText!,
                  textDirection: TextDirection.rtl,
                  style: AppTextStyle.font12TextSecondaryRegularTajawal().copyWith(
                    color: statusColor ?? ColorPalette.textSecondary,
                    fontWeight: FontWeight.w700,
                  ),
                )
              : QuizCompletionBadge(percentage: percentage),
        ),
        verticalSpace(8),
        Directionality(
          textDirection: TextDirection.rtl,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8.h,
              backgroundColor: ColorPalette.wine50,
              valueColor: const AlwaysStoppedAnimation<Color>(ColorPalette.primary),
            ),
          ),
        ),
      ],
    );
  }
}
