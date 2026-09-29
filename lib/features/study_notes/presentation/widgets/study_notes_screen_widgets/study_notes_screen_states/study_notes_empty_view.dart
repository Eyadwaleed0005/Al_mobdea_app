import 'package:al_mobdea/app/routes/app_images_routes.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/app_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StudyNotesEmptyView extends StatelessWidget {
  const StudyNotesEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      title: 'لا توجد مذكرات متاحة حاليًا',
      subtitle: 'ستظهر مذكراتك هنا',
      iconBackgroundColor: ColorPalette.cream50,
      iconContainerSize: 144,
      iconTitleSpacing: 48,
      titleSubtitleSpacing: 8,
      titleStyle: AppTextStyle.font20TextPrimarySemiBoldKufam(),
      subtitleStyle: AppTextStyle.font14TextSecondaryRegularTajawal(),
      iconWidget: SvgPicture.asset(
        AppImage().emptyNotes,
        width: 112.w,
        height: 104.h,
        fit: BoxFit.contain,
      ),
    );
  }
}
