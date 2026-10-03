import 'package:al_mobdea/app/routes/app_images_routes.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/features/app_startup/presentation/widgets/typewriter_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLogInLogo extends StatelessWidget {
  const CustomLogInLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175.w,
      height: 74.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: ColorPalette.primaryPressed,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: ColorPalette.primary.withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        child: TypewriterImage(
          duration: Duration(seconds: 2),
          imagePath: AppImage().alMobdea,
          width: 145.w,
        ),
      ),
    );
  }
}
