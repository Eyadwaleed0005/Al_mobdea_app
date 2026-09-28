import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamAnswerOptionTile extends StatelessWidget {
  const ExamAnswerOptionTile({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Ink(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? ColorPalette.wine50
                  : ColorPalette.surface,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isSelected ? ColorPalette.primary : ColorPalette.border,
                width: isSelected ? 1.5.w : 1.2.w,
              ),
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                children: [
                  _buildRadioIndicator(),
                  horizontalSpace(14),
                  Expanded(
                    child: Text(
                      text,
                      style: AppTextStyle.font13TextPrimaryMediumTajawal(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRadioIndicator() {
    return Container(
      width: 22.r,
      height: 22.r,
      decoration: BoxDecoration(
        color: isSelected ? ColorPalette.primary : const Color(0xFFD3D3D3),
        shape: BoxShape.circle,
      ),
    );
  }
}
