import 'package:al_mobdea/core/helper/arabic_numbers_helper.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';

class QuizHeader extends StatelessWidget {
  const QuizHeader({
    super.key,
    required this.current,
    required this.total,
    this.totalScore,
  });

  final int current;
  final int total;
  final int? totalScore;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${toArabicNumbers(totalScore ?? 0)} درجات',
          textDirection: TextDirection.rtl,
          style: AppTextStyle.font14TextPrimaryBoldTajawal(),
        ),
        Text(
          'السؤال ${toArabicNumbers(current)} من ${toArabicNumbers(total)}',
          textDirection: TextDirection.rtl,
          style: AppTextStyle.font14TextPrimaryBoldTajawal(),
        ),
      ],
    );
  }
}

class QuizCompletionBadge extends StatelessWidget {
  const QuizCompletionBadge({super.key, required this.percentage});

  final int percentage;

  @override
  Widget build(BuildContext context) {
    return Text(
      '%${toArabicNumbers(percentage)} مكتمل',
      textDirection: TextDirection.rtl,
      style: AppTextStyle.font12TextSecondaryRegularTajawal().copyWith(
        color: ColorPalette.textSecondary,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
