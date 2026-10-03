import 'package:al_mobdea/app/routes/app_images_routes.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LiveSessionBanner extends StatelessWidget {
  const LiveSessionBanner({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 350 / 270,
      child: Container(
        decoration: BoxDecoration(
          color: ColorPalette.wine600,
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(color: ColorPalette.wine300, width: 1.2.w),
          boxShadow: [
            BoxShadow(
              color: ColorPalette.cardShadow.withValues(alpha: 0.17),
              blurRadius: 20.r,
              offset: Offset(0, 10.h),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Positioned(
                  left: -25.w,
                  bottom: -5.h,
                  width: constraints.maxWidth * 0.60,
                  height: constraints.maxHeight * 0.91,
                  child: Image.asset(
                    AppImage().splashLogo,
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomCenter,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                Positioned(
                  top: 15.h,
                  right: 17.w,
                  bottom: 17.h,
                  width: constraints.maxWidth * 0.87,
                  child: _BannerCopy(onTap: onTap),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _BannerCopy extends StatelessWidget {
  const _BannerCopy({this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: TextDirection.rtl,
          children: [
            const _LiveBadge(),
            Text(
              'درس مباشر',
              textDirection: TextDirection.rtl,
              style: AppTextStyle.font13Gold300SemiBoldTajawal(),
            ),
          ],
        ),
        verticalSpace(21),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: 31.w,
            height: 3.h,
            decoration: BoxDecoration(
              color: ColorPalette.gold300,
              borderRadius: BorderRadius.circular(3.r),
            ),
          ),
        ),
        verticalSpace(14),
        Text(
          'مع الأستاذ',
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          style: AppTextStyle.font14Gold300MediumTajawal(),
        ),
        verticalSpace(5),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerRight,
          child: Text(
            'محمد زينهم الكرداوي',
            textDirection: TextDirection.rtl,
            maxLines: 1,
            style: AppTextStyle.font15CreamBoldKufam(),
          ),
        ),
        verticalSpace(14),
        Text(
          'شرح وتفاعل مباشر',
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          style: AppTextStyle.font14CreamRegularTajawal(),
        ),
        const Spacer(),
        Align(
          alignment: Alignment.centerRight,
          child: Material(
            color: ColorPalette.gold300,
            borderRadius: BorderRadius.circular(14.r),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(14.r),
              child: SizedBox(
                width: 142.w,
                height: 42.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  textDirection: TextDirection.rtl,
                  children: [
                    Text(
                      'ادخل البث',
                      textDirection: TextDirection.rtl,
                      style: AppTextStyle.font16TextPrimaryMediumTajawal(),
                    ),
                    horizontalSpace(8),
                    Icon(Icons.arrow_back_rounded, color: ColorPalette.textPrimary, size: 19.r),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LiveBadge extends StatelessWidget {
  const _LiveBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: ColorPalette.cream50,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        textDirection: TextDirection.ltr,
        children: [
          Container(
            width: 9.r,
            height: 9.r,
            decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
          ),
          horizontalSpace(6),
          Text('LIVE', style: AppTextStyle.font12Wine600BoldTajawal()),
        ],
      ),
    );
  }
}
