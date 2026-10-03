import 'package:al_mobdea/app/routes/app_images_routes.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.onNotificationPressed});

  final VoidCallback onNotificationPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomAppBar(
              title: 'الرئيسية',
              titleColor: ColorPalette.surface,
              titleBackgroundColor: ColorPalette.primary,
              backgroundColor: Colors.transparent,
              showBackButton: false,
              toolbarHeight: 48.h,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Semantics(
              button: true,
              label: 'الإشعارات',
              child: Material(
                color: Colors.white,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: onNotificationPressed,
                  customBorder: const CircleBorder(),
                  child: Container(
                    width: 44.w,
                    height: 44.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: ColorPalette.border, width: 1),
                    ),
                    child: SvgPicture.asset(AppImage().notifications, width: 21.w, height: 22.w),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
