import 'package:al_mobdea/app/routes/app_images_routes.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/widgets/background/background_student_layout.dart';
import 'package:al_mobdea/core/widgets/custom_app_bar.dart';
import 'package:al_mobdea/features/study_notes/domain/entities/study_note_entity.dart';
import 'package:al_mobdea/features/study_notes/presentation/widgets/study_note_pdf_reader_screen_widgets/study_note_pdf_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StudyNotePdfReaderContent extends StatelessWidget {
  const StudyNotePdfReaderContent({super.key, required this.note});

  final StudyNoteEntity note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.background,
      appBar: CustomAppBar(
        title: note.name,
        titleColor: ColorPalette.textLight,
        backButtonColor: ColorPalette.textLight,
        backgroundColor: ColorPalette.primary,
        showBackButton: true,
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.only(end: 16.w),
            child: SvgPicture.asset(
              AppImage().studyNotes,
              width: 24.w,
              height: 24.h,
              colorFilter: const ColorFilter.mode(
                ColorPalette.textLight,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      body: BackgroundStudentLayout(child: StudyNotePdfBody(note: note)),
    );
  }
}
