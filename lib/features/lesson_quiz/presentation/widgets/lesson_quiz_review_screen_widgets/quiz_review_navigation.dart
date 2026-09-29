import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/custom_button.dart';
import 'package:al_mobdea/core/widgets/custom_secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizReviewNavigation extends StatelessWidget {
  const QuizReviewNavigation({
    super.key,
    required this.isFirstQuestion,
    required this.isLastQuestion,
    this.onPrevious,
    required this.onNext,
  });

  final bool isFirstQuestion;
  final bool isLastQuestion;
  final VoidCallback? onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Expanded(
          flex: 4,
          child: CustomSecondaryButton(
            text: 'السابق',
            onPressed: onPrevious,
            backgroundColor: ColorPalette.surface,
            borderColor: ColorPalette.border,
            borderWidth: 1.2,
            foregroundColor: ColorPalette.textPrimary,
            textStyle: AppTextStyle.font14TextPrimaryBoldTajawal(),
            borderRadius: 30,
            height: 48.h,
          ),
        ),
        horizontalSpace(10),
        Expanded(
          flex: 6,
          child: CustomButton(
            text: isLastQuestion ? 'إنهاء المراجعة' : 'التالي ←',
            onPressed: onNext,
            background: ColorPalette.primary,
            foreground: ColorPalette.textLight,
            textStyle: AppTextStyle.font14TextLightBoldTajawal(),
            borderRadius: 30,
            height: 48.h,
          ),
        ),
      ],
    );
  }
}

class QuizReviewHint extends StatelessWidget {
  const QuizReviewHint({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      textDirection: TextDirection.rtl,
      children: [
        Icon(
          Icons.info_outline_rounded,
          color: ColorPalette.success,
          size: 16.sp,
        ),
        horizontalSpace(8),
        Flexible(
          child: Text(
            'الإجابة الصحيحة موضحة باللون الأخضر.',
            style: AppTextStyle.font12TextSecondaryRegularTajawal().copyWith(
              color: ColorPalette.success,
            ),
            textDirection: TextDirection.rtl,
          ),
        ),
      ],
    );
  }
}
