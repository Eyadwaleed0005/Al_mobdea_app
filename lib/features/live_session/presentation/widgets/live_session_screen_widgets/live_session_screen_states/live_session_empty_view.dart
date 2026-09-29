import 'package:al_mobdea/app/routes/app_images_routes.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LiveSessionEmptyView extends StatelessWidget {
  const LiveSessionEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppImage().emptySession,
            width: 112.w,
            height: 112.w,
            fit: BoxFit.contain,
            semanticsLabel: 'كاميرا مغلقة',
          ),
          verticalSpace(22),
          Text(
            'لا توجد حصة مباشرة الآن',
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: AppTextStyle.font23TextDarkBoldKufam().copyWith(
              fontSize: 22.sp,
              color: ColorPalette.textPrimary,
            ),
          ),
          verticalSpace(28),
          Text(
            'سيظهر رابط الحصة هنا فور إضافته من المدرس.',
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: AppTextStyle.font14TextSecondaryRegularTajawal(),
          ),
          verticalSpace(4),
          Text(
            'ارجع في موعد الحصة المعلن.',
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: AppTextStyle.font14TextSecondaryRegularTajawal(),
          ),
        ],
      ),
    );
  }
}
