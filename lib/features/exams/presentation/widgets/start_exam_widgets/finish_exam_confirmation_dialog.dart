import 'package:al_mobdea/core/helper/arabic_numbers_helper.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/custom_button.dart';
import 'package:al_mobdea/core/widgets/custom_secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinishExamConfirmationDialog extends StatelessWidget {
  const FinishExamConfirmationDialog({
    super.key,
    this.answeredCount = 0,
    this.totalQuestions = 0,
    required this.onConfirmFinish,
    this.onCancel,
  });

  final int answeredCount;
  final int totalQuestions;
  final VoidCallback onConfirmFinish;
  final VoidCallback? onCancel;

  static Future<bool?> show(
    BuildContext context, {
    int answeredCount = 0,
    int totalQuestions = 0,
    required VoidCallback onConfirmFinish,
  }) {
    return showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (context) => FinishExamConfirmationDialog(
        answeredCount: answeredCount,
        totalQuestions: totalQuestions,
        onConfirmFinish: () {
          Navigator.of(context).pop(true);
          onConfirmFinish();
        },
        onCancel: () => Navigator.of(context).pop(false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Container(
        padding: EdgeInsets.all(22.w),
        decoration: BoxDecoration(
          color: ColorPalette.surface,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: ColorPalette.cardShadow.withValues(alpha: 0.1),
              blurRadius: 16.r,
              offset: Offset(0, 6.h),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: ColorPalette.wine50,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Center(
                child: Icon(
                  Icons.assignment_turned_in_outlined,
                  color: ColorPalette.primary,
                  size: 32.sp,
                ),
              ),
            ),
            verticalSpace(18),
            Text(
              'هل أنت متأكد من إنهاء الاختبار؟',
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: AppTextStyle.font18TextPrimaryBoldKufam(),
            ),
            verticalSpace(8),
            Text(
              'لن تتمكن من تعديل إجاباتك بعد تسليم الاختبار.',
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: AppTextStyle.font14TextSecondaryRegularTajawal(),
            ),
            verticalSpace(16),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: ColorPalette.cream100,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Text(
                'تمت الإجابة عن ${toArabicNumbers(answeredCount)} من ${toArabicNumbers(totalQuestions)} سؤالًا',
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: AppTextStyle.font14TextPrimaryBoldTajawal(),
              ),
            ),
            verticalSpace(20),
            CustomButton(
              text: 'إنهاء وتسليم الاختبار',
              onPressed: onConfirmFinish,
              background: ColorPalette.primary,
              foreground: ColorPalette.textLight,
              borderRadius: 30,
              height: 48.h,
            ),
            verticalSpace(10),
            CustomSecondaryButton(
              text: 'العودة للاختبار',
              onPressed: onCancel ?? () => Navigator.of(context).pop(),
              backgroundColor: ColorPalette.surface,
              borderColor: ColorPalette.border,
              foregroundColor: ColorPalette.textPrimary,
              borderRadius: 30,
              height: 48.h,
            ),
          ],
        ),
      ),
    );
  }
}
