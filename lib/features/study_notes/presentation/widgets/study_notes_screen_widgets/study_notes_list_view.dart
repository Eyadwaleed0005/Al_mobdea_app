import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/custom_app_bar.dart';
import 'package:al_mobdea/features/study_notes/domain/entities/study_note_entity.dart';
import 'package:al_mobdea/features/study_notes/presentation/widgets/study_notes_screen_widgets/study_note_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudyNotesListView extends StatelessWidget {
  const StudyNotesListView({
    super.key,
    required this.notes,
    required this.onNoteTap,
  });

  final List<StudyNoteEntity> notes;
  final ValueChanged<StudyNoteEntity> onNoteTap;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: 112.h),
      itemCount: notes.length + 1,
      separatorBuilder: (_, index) =>
          index == 0 ? const SizedBox.shrink() : verticalSpace(14),
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                verticalSpace(10),
                CustomAppBar(
                  titleWidget: Container(
                    width: 168.w,
                    height: 44.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ColorPalette.primary,
                      borderRadius: BorderRadius.circular(28.r),
                    ),
                    child: Text(
                      'المذكرات',
                      textDirection: TextDirection.rtl,
                      style: AppTextStyle.font22TextLightBoldKufam(),
                    ),
                  ),
                  backgroundColor: ColorPalette.background.withValues(alpha: 0),
                  showBackButton: false,
                  toolbarHeight: 56.h,
                ),
                verticalSpace(14),
                Text(
                  'ملخصات منظمة ترجع لها في أي وقت',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.font14TextSecondaryRegularTajawal(),
                ),
                verticalSpace(14),
              ],
            ),
          );
        }

        final noteIndex = index - 1;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: StudyNotePreviewCard(
            note: notes[noteIndex],
            onTap: () => onNoteTap(notes[noteIndex]),
            badgeColor: noteIndex.isEven
                ? ColorPalette.primarySoftBackground
                : ColorPalette.goldPale,
          ),
        );
      },
    );
  }
}
