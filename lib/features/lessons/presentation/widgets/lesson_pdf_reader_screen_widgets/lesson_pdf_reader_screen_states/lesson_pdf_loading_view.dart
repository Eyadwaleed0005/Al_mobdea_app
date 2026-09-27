import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/features/lessons/presentation/widgets/lesson_pdf_reader_screen_widgets/lesson_pdf_state_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonPdfLoadingView extends StatelessWidget {
  const LessonPdfLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonPdfStateLayout(
      child: Padding(
        padding: EdgeInsets.all(28.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox.square(
              dimension: 40.w,
              child: const CircularProgressIndicator(
                color: ColorPalette.primary,
                strokeWidth: 3,
              ),
            ),
            verticalSpace(16),
            Text(
              'جارٍ تحميل الملف',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: AppTextStyle.font17TextPrimarySemiBoldKufam(),
            ),
            verticalSpace(8),
            Text(
              'سيكون الملف متاحًا للقراءة دون اتصال بعد تنزيله.',
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
