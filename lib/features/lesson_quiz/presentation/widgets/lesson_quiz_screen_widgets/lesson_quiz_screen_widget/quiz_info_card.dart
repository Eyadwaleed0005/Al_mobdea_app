import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuizInfoCard extends StatelessWidget {
  const QuizInfoCard({
    super.key,
    required this.scoreText,
    required this.retryText,
  });

  final String scoreText;
  final String retryText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: ColorPalette.surface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: ColorPalette.borderWarm.withValues(alpha: 0.6),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorPalette.cardShadow.withValues(alpha: 0.04),
            blurRadius: 16.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Expanded(
            child: _buildStatTile(
              background: ColorPalette.goldPale,
              valueText: retryText,
              labelText: 'إعادة المحاولة',
            ),
          ),
          horizontalSpace(12),
          Expanded(
            child: _buildStatTile(
              background: ColorPalette.primarySoftBackground,
              valueText: scoreText,
              labelText: 'الدرجة',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatTile({
    required Color background,
    required String valueText,
    required String labelText,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          Text(
            valueText,
            textDirection: TextDirection.rtl,
            style: AppTextStyle.font24PrimaryBoldKufam(),
          ),
          verticalSpace(8),
          Text(
            labelText,
            textDirection: TextDirection.rtl,
            style: AppTextStyle.font14TextSecondaryRegularTajawal(),
          ),
        ],
      ),
    );
  }
}
