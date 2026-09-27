import 'package:al_mobdea/core/helper/launch_url.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LiveSessionLink extends StatelessWidget {
  const LiveSessionLink({super.key, required this.sessionLink});

  final String sessionLink;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: ColorPalette.cream50,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: Text(
                sessionLink,
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.left,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.font14TextSecondaryRegularTajawal().copyWith(
                  color: ColorPalette.error,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          horizontalSpace(10),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => UrlLauncherHelper.launchSessionUrl(sessionLink),
              borderRadius: BorderRadius.circular(12.r),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.login_rounded,
                      size: 22.r,
                      color: ColorPalette.primary,
                    ),
                    verticalSpace(1),
                    Text(
                      'انضم',
                      textDirection: TextDirection.rtl,
                      style: AppTextStyle.font12TextPrimaryRegularTajawal().copyWith(
                        color: ColorPalette.error,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
