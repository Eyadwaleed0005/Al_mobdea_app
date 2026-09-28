import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonOverviewCard extends StatelessWidget {
  const LessonOverviewCard({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: ColorPalette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Container(
                width: 4.w,
                height: 25.h,
                decoration: BoxDecoration(
                  color: ColorPalette.primary,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              horizontalSpace(10),
              Text(
                'عن الدرس',
                textDirection: TextDirection.rtl,
                style: AppTextStyle.font17TextPrimarySemiBoldKufam(),
              ),
            ],
          ),
          verticalSpace(14),
          Text(
            description,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            style: AppTextStyle.font15TextSecondaryRegularTajawal().copyWith(
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
