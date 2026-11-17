import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileActionCard extends StatelessWidget {
  const ProfileActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.showArrow = true,
    this.isDestructive = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool showArrow;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final foregroundColor = isDestructive
        ? ColorPalette.error
        : ColorPalette.primary;

    final borderRadius = BorderRadius.circular(18.r);

    return Material(
      color: ColorPalette.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: const BorderSide(color: ColorPalette.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              SizedBox(
                width: 42.r,
                height: 42.r,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: isDestructive
                        ? ColorPalette.error.withValues(alpha: 0.08)
                        : ColorPalette.primarySoftBackground,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(icon, color: foregroundColor, size: 24.sp),
                ),
              ),
              horizontalSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      title,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: AppTextStyle.font14TextPrimarySemiBoldKufam()
                          .copyWith(
                            color: isDestructive
                                ? ColorPalette.error
                                : ColorPalette.textPrimary,
                          ),
                    ),
                    verticalSpace(6),
                    Text(
                      subtitle,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: AppTextStyle.font12TextSecondaryRegularTajawal()
                          .copyWith(height: 1.5),
                    ),
                  ],
                ),
              ),
              if (showArrow && onTap != null) ...[
                horizontalSpace(8),
                Icon(
                  Icons.chevron_left_rounded,
                  color: foregroundColor,
                  size: 24.sp,
                  textDirection: TextDirection.ltr,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
