import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/features/profile/domain/entities/profile_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileStudentCard extends StatelessWidget {
  const ProfileStudentCard({super.key, required this.profile});

  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    final studentProfile = profile.studentProfile;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: ColorPalette.primaryPressed,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: ColorPalette.cardShadow.withValues(alpha: 0.22),
            blurRadius: 24.r,
            offset: Offset(0, 12.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Container(
              width: 88.w,
              height: 88.w,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: ColorPalette.goldLight,
                shape: BoxShape.circle,
              ),
              child: Text(
                _initialLetter(studentProfile.name),
                textDirection: TextDirection.rtl,
                style: AppTextStyle.font24PrimaryBoldKufam().copyWith(fontSize: 34.sp),
              ),
            ),
          ),
          verticalSpace(18),
          Text(
            studentProfile.name,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            style: AppTextStyle.font20TextLightBoldKufam(),
          ),
          verticalSpace(6),
          Text(
            'طالب ${profile.grade.name}',
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.right,
            style: AppTextStyle.font14TextLightSemiBoldTajawal(),
          ),
        ],
      ),
    );
  }

  String _initialLetter(String name) {
    final trimmedName = name.trim();

    if (trimmedName.isEmpty) {
      return '؟';
    }

    // Arabic letters are single UTF-16 code units, so a direct substring of
    // the first code unit is enough for the avatar initial.
    return trimmedName.substring(0, 1);
  }
}
