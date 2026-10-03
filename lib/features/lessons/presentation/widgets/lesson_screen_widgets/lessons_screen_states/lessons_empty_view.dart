import 'package:al_mobdea/app/routes/app_images_routes.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LessonsEmptyView extends StatelessWidget {
  const LessonsEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppImage().lessonsEmptyIcon, width: 160.w, height: 160.w),
            verticalSpace(20),
            Text(
              'لا توجد دروس متاحة حاليًا',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: AppTextStyle.font20TextBlackSemiBoldKufam(),
            ),
            verticalSpace(100),
          ],
        ),
      ),
    );
  }
}
