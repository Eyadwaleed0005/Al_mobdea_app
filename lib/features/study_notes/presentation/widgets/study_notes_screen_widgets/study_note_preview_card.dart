import 'package:al_mobdea/core/helper/app_date_time_formatter.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/features/study_notes/domain/entities/study_note_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudyNotePreviewCard extends StatelessWidget {
  const StudyNotePreviewCard({
    super.key,
    required this.note,
    required this.onTap,
    required this.badgeColor,
  });

  final StudyNoteEntity note;
  final VoidCallback onTap;
  final Color badgeColor;

  String get _formattedUpdatedAt {
    final updatedAt = note.updatedAt;

    if (updatedAt == null) {
      return 'ملف PDF';
    }

    final formattedDate = AppDateTimeFormatter.formatDate(updatedAt);

    return 'ملف PDF · محدث في $formattedDate';
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      color: ColorPalette.background.withValues(alpha: 0),
      borderRadius: BorderRadius.circular(22.r),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        splashColor: ColorPalette.primarySoftBackground,
        highlightColor: ColorPalette.primarySoftBackground,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorPalette.surface,
            borderRadius: BorderRadius.circular(22.r),
            border: Border.all(color: ColorPalette.border, width: 1.w),
            boxShadow: [
              BoxShadow(
                color: ColorPalette.cardShadow.withValues(alpha: 0.07),
                blurRadius: 18.r,
                offset: Offset(0, 6.h),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
            child: Row(
              textDirection: TextDirection.ltr,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: ColorPalette.primarySoftBackground,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Text(
                    'عرض',
                    style: AppTextStyle.font14TextPrimaryBoldTajawal().copyWith(
                      color: ColorPalette.primary,
                    ),
                  ),
                ),
                horizontalSpace(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        note.name,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.font14TextPrimarySemiBoldKufam(),
                      ),
                      verticalSpace(6),
                      Text(
                        note.description.isEmpty ? _formattedUpdatedAt : note.description,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.font12TextSecondaryRegularTajawal(),
                      ),
                    ],
                  ),
                ),
                horizontalSpace(12),
                Container(
                  width: 62.w,
                  height: 62.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: badgeColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'PDF',
                    textDirection: TextDirection.ltr,
                    style: AppTextStyle.font14TextPrimaryBoldTajawal().copyWith(
                      color: ColorPalette.primary,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
