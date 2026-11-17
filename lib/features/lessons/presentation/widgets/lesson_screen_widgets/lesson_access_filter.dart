import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonAccessFilter extends StatelessWidget {
  const LessonAccessFilter({
    super.key,
    required this.showFree,
    required this.onChanged,
  });

  final bool showFree;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: ColorPalette.cream100,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: ColorPalette.border),
      ),
      child: Padding(
        padding: EdgeInsets.all(4.r),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Expanded(
              child: _buildOption(
                label: 'مجاني',
                selected: showFree,
                onTap: () => onChanged(true),
              ),
            ),
            horizontalSpace(6),
            Expanded(
              child: _buildOption(
                label: 'باشتراك',
                selected: !showFree,
                onTap: () => onChanged(false),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption({
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Semantics(
      selected: selected,
      child: Material(
        color: selected ? ColorPalette.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: selected ? null : onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
            child: Text(
              label,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: AppTextStyle.font14TextPrimaryBoldTajawal().copyWith(
                color: selected
                    ? ColorPalette.textLight
                    : ColorPalette.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
