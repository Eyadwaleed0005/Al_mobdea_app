import 'package:al_mobdea/app/routes/screen_routes/route_names.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/widgets/background/background_student_layout.dart';
import 'package:al_mobdea/core/widgets/curved_app_bar.dart';
import 'package:al_mobdea/features/lessons/domain/entities/lesson_entity.dart';
import 'package:al_mobdea/features/lessons/presentation/widgets/lesson_details_screen_widgets/lesson_material_tile.dart';
import 'package:al_mobdea/features/lessons/presentation/widgets/lesson_details_screen_widgets/lesson_overview_card.dart';
import 'package:al_mobdea/features/lessons/presentation/widgets/lesson_details_screen_widgets/lesson_video_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonDetailsContentScreen extends StatelessWidget {
  const LessonDetailsContentScreen({super.key, required this.lesson});

  final LessonEntity lesson;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BackgroundStudentLayout(
        child: Column(
          children: [
            CurvedAppBar(title: lesson.title),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 30.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (lesson.hasYoutubeVideo) ...[
                      LessonVideoCard(videoUrl: lesson.youtubeUrl),
                      verticalSpace(40),
                    ],
                    LessonOverviewCard(description: lesson.description),
                    verticalSpace(30),
                    Text(
                      'محتوى الدرس',
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.right,
                      style: AppTextStyle.font18TextDarkBoldKufam(),
                    ),
                    verticalSpace(14),
                    LessonMaterialTile(
                      title: 'ملخص الدرس',
                      subtitle: _getPdfSubtitle(),
                      icon: Icons.menu_book_outlined,
                      iconBackground: ColorPalette.wine50,
                      onTap: () =>
                          Navigator.of(context)
                              .pushNamed(RouteNames.lessonDetailsPdf, arguments: lesson),
                    ),
                    verticalSpace(12),
                    LessonMaterialTile(
                      title: 'اختبار ${lesson.title}',
                      subtitle: 'اختبار الدرس',
                      icon: Icons.assignment_turned_in_outlined,
                      iconBackground: ColorPalette.gold50,
                      onTap: () =>
                          Navigator.of(context)
                              .pushNamed(RouteNames.lessonQuiz, arguments: lesson.lessonId),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getPdfSubtitle() {
    if (!lesson.hasPdfFile) {
      return 'لا يوجد ملف متاح حاليًا';
    }
    final fileName = lesson.pdfFileName.trim();
    if (fileName.isEmpty) {
      return 'ملف PDF';
    }
    return 'ملف PDF · $fileName';
  }
}
