import 'package:al_mobdea/app/routes/app_images_routes.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LessonPreviewCard extends StatelessWidget {
  const LessonPreviewCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(22.r);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: ColorPalette.cardShadow.withValues(alpha: .13),
            blurRadius: 14.r,
            offset: Offset(0, 7.h),
          ),
        ],
      ),
      child: Material(
        color: ColorPalette.primary,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 106.h,
            child: Stack(
              children: [
                Positioned(
                  left: 100.w,
                  bottom: -2.h,
                  child: SvgPicture.asset(AppImage().kuficLogo),
                ),
                Positioned(
                  left: 24.w,
                  top: 0,
                  bottom: 0,
                  child: SvgPicture.asset(
                    AppImage().arrowBack,
                    color: ColorPalette.surface,
                    height: 6.h,
                    width: 6.h,
                  ),
                ),
                Positioned.fill(
                  left: 68.w,
                  right: 25.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        textDirection: TextDirection.rtl,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.font15TextLightSemiBoldKufam().copyWith(
                          fontSize: 17.sp,
                        ),
                      ),
                      verticalSpace(10),
                      Text(
                        subtitle,
                        textDirection: TextDirection.rtl,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.font13TextLightSemiBoldTajawal().copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withValues(alpha: .84),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
