import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/features/lessons/presentation/widgets/lesson_pdf_reader_screen_widgets/lesson_pdf_state_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonPdfEmptyView extends StatelessWidget {
  const LessonPdfEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonPdfStateLayout(
      child: Padding(
        padding: EdgeInsets.all(28.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.picture_as_pdf_outlined,
              color: ColorPalette.primary,
              size: 42.sp,
            ),
            verticalSpace(16),
            Text(
              'ملف الدرس غير متاح',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: AppTextStyle.font17TextPrimarySemiBoldKufam(),
            ),
            verticalSpace(8),
            Text(
              'لم تتم إضافة ملخص PDF لهذا الدرس بعد.',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: AppTextStyle.font14TextSecondaryRegularTajawal(),
            ),
          ],
        ),
      ),
    );
  }
}
