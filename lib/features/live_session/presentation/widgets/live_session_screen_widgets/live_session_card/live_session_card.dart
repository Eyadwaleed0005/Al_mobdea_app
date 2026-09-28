import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/features/live_session/domain/entity/live_session_entity.dart';
import 'package:al_mobdea/features/live_session/presentation/widgets/live_session_screen_widgets/live_session_card/live_session_badge_header.dart';
import 'package:al_mobdea/features/live_session/presentation/widgets/live_session_screen_widgets/live_session_card/live_session_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LiveSessionCard extends StatelessWidget {
  const LiveSessionCard({super.key, required this.liveSession});

  final LiveSessionEntity liveSession;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.h),
      decoration: BoxDecoration(
        color: ColorPalette.surface,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: ColorPalette.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: ColorPalette.cardShadow.withValues(alpha: 0.07),
            blurRadius: 18.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                child: Text(
                  'رابط الحصة جاهز',
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: AppTextStyle.font20TextPrimarySemiBoldKufam().copyWith(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              horizontalSpace(12),
              const LiveSessionBadgeHeader(),
            ],
          ),
          verticalSpace(12),
          Text(
            'افتح الرابط أو انسخه للانضمام إلى الحصة.',
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: AppTextStyle.font14TextSecondaryRegularTajawal(),
          ),
          verticalSpace(28),
          LiveSessionLink(sessionLink: liveSession.meetingUrl),
        ],
      ),
    );
  }
}
