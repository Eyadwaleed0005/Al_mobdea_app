import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
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
      itemCount: notes.length,
      separatorBuilder: (_, _) => verticalSpace(14),
      itemBuilder: (context, index) {
        return StudyNotePreviewCard(
          note: notes[index],
          onTap: () => onNoteTap(notes[index]),
          badgeColor: index.isEven
              ? ColorPalette.primarySoftBackground
              : ColorPalette.goldPale,
        );
      },
    );
  }
}
