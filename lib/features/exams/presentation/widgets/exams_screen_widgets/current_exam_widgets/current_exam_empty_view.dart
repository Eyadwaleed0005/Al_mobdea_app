import 'package:al_mobdea/app/routes/app_images_routes.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CurrentExamEmptyView extends StatelessWidget {
  const CurrentExamEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AppImage().emptyExams,
              width: 77.w,
              height: 109.h,
              fit: BoxFit.contain,
            ),
            verticalSpace(28),
            Text(
              'لا يوجد امتحان حاليًا',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: AppTextStyle.font22TextPrimarySemiBoldKufam(),
            ),
            verticalSpace(12),
            Text(
              'سيظهر الاختبار هنا بمجرد أن ينشره المدرس.\nكل شيء محدث، ارجع لاحقًا.',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: AppTextStyle.font14TextSecondaryRegularTajawal().copyWith(
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
