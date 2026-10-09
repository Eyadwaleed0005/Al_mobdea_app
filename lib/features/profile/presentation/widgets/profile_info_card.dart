import 'package:al_mobdea/core/helper/app_date_time_formatter.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/app_toast.dart';
import 'package:al_mobdea/features/profile/domain/entities/profile_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({super.key, required this.profile});

  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    final studentProfile = profile.studentProfile;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ColorPalette.surface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: ColorPalette.border, width: 1.w),
        boxShadow: [
          BoxShadow(
            color: ColorPalette.cardShadow.withValues(alpha: 0.06),
            blurRadius: 18.r,
            offset: Offset(0, 8.h),
          ),
        ],
      ),
      child: Column(
        children: [
          ProfileInfoTile(
            label: 'البريد الإلكتروني',
            value: studentProfile.email,
            isCopyable: true,
          ),
          ProfileInfoTile(label: 'الصف الدراسي', value: profile.grade.name),
          ProfileInfoTile(
            label: 'بداية الاشتراك',
            value: AppDateTimeFormatter.formatDateWithSlash(
              studentProfile.subscriptionStartAt,
              useArabicDigits: false,
            ),
          ),
          ProfileInfoTile(
            label: 'نهاية الاشتراك',
            value: AppDateTimeFormatter.formatDateWithSlash(
              studentProfile.subscriptionEndAt,
              useArabicDigits: false,
            ),
            showDivider: false,
          ),
        ],
      ),
    );
  }
}

class ProfileInfoTile extends StatelessWidget {
  const ProfileInfoTile({
    super.key,
    required this.label,
    required this.value,
    this.showDivider = true,
    this.isCopyable = false,
  });

  final String label;
  final String value;
  final bool showDivider;
  final bool isCopyable;

  Future<void> _copyValue(BuildContext context) async {
    final text = value.trim();

    if (text.isEmpty) {
      return;
    }

    await Clipboard.setData(ClipboardData(text: text));

    if (!context.mounted) {
      return;
    }

    showAppToast(context, message: 'تم نسخ البريد الإلكتروني', icon: Icons.check_circle_rounded);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isCopyable ? () => _copyValue(context) : null,
            borderRadius: BorderRadius.circular(8.r),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    label,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: AppTextStyle.font13TextSecondaryRegularTajawal(),
                  ),
                  verticalSpace(6),
                  Text(
                    value,
                    textDirection: _resolveTextDirection(value),
                    textAlign: TextAlign.right,
                    style: AppTextStyle.font15TextPrimaryMediumTajawal(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          Divider(color: ColorPalette.border.withValues(alpha: 0.5), thickness: 1.h, height: 1.h),
      ],
    );
  }

  TextDirection _resolveTextDirection(String text) {
    final arabicLetterPattern = RegExp(r'[\u0600-\u06FF]');

    return arabicLetterPattern.hasMatch(text) ? TextDirection.rtl : TextDirection.ltr;
  }
}
