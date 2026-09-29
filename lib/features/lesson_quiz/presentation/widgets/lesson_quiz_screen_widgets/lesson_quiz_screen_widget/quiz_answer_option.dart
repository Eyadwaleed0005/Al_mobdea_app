import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizAnswerOption extends StatelessWidget {
  const QuizAnswerOption({
    super.key,
    required this.title,
    this.isSelected = false,
    this.onTap,
    this.isCorrect,
  });

  final String title;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool? isCorrect;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = ColorPalette.surface;
    Color borderColor = ColorPalette.border;
    Color textColor = ColorPalette.textPrimary;
    Color indicatorColor = const Color(0xFFD3D3D3);
    Color? innerDotColor;

    if (isCorrect != null) {
      if (isCorrect == true) {
        backgroundColor = const Color(0xFFE8F5E9);
        borderColor = const Color(0xFF2E7D32);
        textColor = ColorPalette.textPrimary;
        indicatorColor = const Color(0xFF2E7D32);
        innerDotColor = ColorPalette.wine50;
      } else {
        backgroundColor = ColorPalette.error.withValues(alpha: 0.06);
        borderColor = ColorPalette.error;
        textColor = ColorPalette.error;
        indicatorColor = ColorPalette.error;
        innerDotColor = ColorPalette.error;
      }
    } else if (isSelected) {
      backgroundColor = ColorPalette.primarySoftBackground;
      borderColor = ColorPalette.primary;
      textColor = ColorPalette.primary;
      indicatorColor = ColorPalette.primary;
      innerDotColor = ColorPalette.primary;
    }

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(16.r),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: borderColor,
              width: (isSelected || isCorrect != null) ? 1.5.w : 1.2.w,
            ),
          ),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: AppTextStyle.font13TextPrimaryMediumTajawal()
                      .copyWith(
                        color: textColor,
                        fontWeight: (isSelected || isCorrect != null)
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                ),
              ),
              horizontalSpace(12),
              Container(
                width: 24.w,
                height: 24.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: indicatorColor, width: 2.w),
                ),
                child: innerDotColor != null
                    ? Container(
                        width: 11.w,
                        height: 11.w,
                        decoration: BoxDecoration(
                          color: innerDotColor,
                          shape: BoxShape.circle,
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
