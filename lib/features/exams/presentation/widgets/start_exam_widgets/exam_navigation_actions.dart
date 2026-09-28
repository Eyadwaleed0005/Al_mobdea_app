import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/custom_button.dart';
import 'package:al_mobdea/core/widgets/custom_secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamNavigationActions extends StatelessWidget {
  const ExamNavigationActions({
    super.key,
    this.onPreviousPressed,
    this.onNextPressed,
    this.onSubmitPressed,
    this.isSubmitting = false,
  });

  final VoidCallback? onPreviousPressed;
  final VoidCallback? onNextPressed;
  final VoidCallback? onSubmitPressed;
  final bool isSubmitting;

  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        Expanded(
          flex: 5,
          child: CustomButton(
            text: 'تسليم الامتحان',
            onPressed: isSubmitting ? null : onSubmitPressed,
            isLoading: isSubmitting,
            background: ColorPalette.goldHighlight,
            foreground: ColorPalette.wine600,
            textStyle: AppTextStyle.font14TextPrimaryBoldTajawal().copyWith(fontSize: 13.sp),
            borderRadius: 30,
            height: 48.h,
          ),
        ),
        horizontalSpace(10),
        Expanded(
          flex: 3,
          child: CustomButton(
            text: 'التالي',
            onPressed: isSubmitting ? null : onNextPressed,
            background: ColorPalette.primary,
            foreground: ColorPalette.textLight,
            textStyle: AppTextStyle.font14TextLightBoldTajawal(),
            borderRadius: 30,
            height: 48.h,
          ),
        ),
        horizontalSpace(10),
        Expanded(
          flex: 4,
          child: CustomSecondaryButton(
            text: 'السابق',
            onPressed: isSubmitting ? null : onPreviousPressed,
            backgroundColor: ColorPalette.surface,
            borderColor: ColorPalette.border,
            borderWidth: 1.2,
            foregroundColor: ColorPalette.textPrimary,
            textStyle: AppTextStyle.font14TextPrimaryBoldTajawal(),
            borderRadius: 30,
            height: 48.h,
          ),
        ),
      ],
    );
  }
}
