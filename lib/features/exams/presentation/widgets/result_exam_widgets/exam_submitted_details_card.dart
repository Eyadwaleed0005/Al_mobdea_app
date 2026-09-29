import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamSubmittedDetailsCard extends StatelessWidget {
  const ExamSubmittedDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: ColorPalette.surface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: ColorPalette.borderWarm.withValues(alpha: 0.6), width: 1.w),
        boxShadow: [
          BoxShadow(
            color: ColorPalette.cardShadow.withValues(alpha: 0.04),
            blurRadius: 16.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildItem(
            label: 'حالة المحاولة',
            badgeText: 'تم التسليم',
            badgeBgColor: ColorPalette.success.withValues(alpha: 0.1),
            badgeTextColor: ColorPalette.success,
            dotColor: ColorPalette.success,
          ),
          verticalSpace(12),
          _buildItem(
            label: 'النتيجة',
            badgeText: 'متاحة للمدرس فقط',
            badgeBgColor: ColorPalette.borderWarm.withValues(alpha: 0.35),
            badgeTextColor: ColorPalette.textSecondary,
            dotColor: ColorPalette.disabled,
          ),
          verticalSpace(12),
          _buildItem(
            label: 'ملاحظات المعلم',
            badgeText: 'بانتظار مراجعة المعلم',
            badgeBgColor: ColorPalette.success.withValues(alpha: 0.1),
            badgeTextColor: ColorPalette.success,
            dotColor: ColorPalette.success,
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required String label,
    required String badgeText,
    required Color badgeBgColor,
    required Color badgeTextColor,
    required Color dotColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),        decoration: BoxDecoration(
          color: ColorPalette.cardFillSoft,
          borderRadius: BorderRadius.circular(16.r),
        ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: badgeBgColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 7.r,
                  height: 7.r,
                  decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
                ),
                horizontalSpace(6),
                Text(
                  badgeText,
                  style: AppTextStyle.font12TextPrimaryMediumTajawal().copyWith(
                    color: badgeTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Text(
            label,
            textDirection: TextDirection.rtl,
            style: AppTextStyle.font14TextSecondaryRegularTajawal().copyWith(
              color: ColorPalette.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
