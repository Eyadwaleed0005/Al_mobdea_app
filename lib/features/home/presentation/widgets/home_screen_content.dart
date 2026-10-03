import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/features/home/presentation/widgets/home_header.dart';
import 'package:al_mobdea/features/home/presentation/widgets/home_quick_links_section.dart';
import 'package:al_mobdea/features/home/presentation/widgets/live_session_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreenContent extends StatelessWidget {
  const HomeScreenContent({super.key, required this.onLiveSessionPressed});

  final VoidCallback onLiveSessionPressed;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HomeHeader(onNotificationPressed: () => {}),
          verticalSpace(22),
          Text(
            'دروس ومحاضرات واختبارات في مكان واحد',
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: AppTextStyle.font14TextSecondaryRegularTajawal(),
          ),
          verticalSpace(14),
          Text(
            'بث مباشر',
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: AppTextStyle.font21TextDarkBoldKufam(),
          ),
          verticalSpace(14),
          LiveSessionBanner(onTap: onLiveSessionPressed),
          SizedBox(height: 36.h),
          const HomeQuickLinksSection(),
        ],
      ),
    );
  }
}
