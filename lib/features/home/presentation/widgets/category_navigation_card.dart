import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryNavigationCard extends StatelessWidget {
  const CategoryNavigationCard({
    super.key,
    required this.label,
    required this.details,
    required this.image,
    this.onTap,
  });

  final String label;
  final String details;
  final String image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorPalette.surface,
      borderRadius: BorderRadius.circular(20.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          height: 126.h,
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 11.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: ColorPalette.border, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(image, width: 31.w, height: 31.w),
              verticalSpace(7),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  maxLines: 1,
                  textDirection: TextDirection.rtl,
                  style: AppTextStyle.font14TextPrimaryMediumKufam(),
                ),
              ),
              verticalSpace(8),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  details,
                  maxLines: 1,
                  textDirection: TextDirection.rtl,
                  style: AppTextStyle.font12TextSecondaryRegularTajawal(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
