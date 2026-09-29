import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LiveSessionErrorView extends StatelessWidget {
  const LiveSessionErrorView({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  final String errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.wifi_off_rounded,
              size: 42.r,
              color: ColorPalette.error,
            ),
            verticalSpace(14),
            Text(
              errorMessage,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: AppTextStyle.font14TextSecondaryRegularTajawal(),
            ),
            verticalSpace(20),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(
                'حاول مرة أخرى',
                style: AppTextStyle.font14TextLightSemiBoldTajawal(),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorPalette.primary,
                foregroundColor: ColorPalette.surface,
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 11.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
