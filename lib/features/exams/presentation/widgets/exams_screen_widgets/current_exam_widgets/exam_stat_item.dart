import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamStatItem extends StatelessWidget {
  const ExamStatItem({super.key, required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: ColorPalette.cardFillSoft,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: AppTextStyle.font20TextPrimarySemiBoldKufam().copyWith(
              color: ColorPalette.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(4),
          Text(
            label,
            style: AppTextStyle.font12TextSecondaryRegularTajawal(),
          ),
        ],
      ),
    );
  }
}
