import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/features/lessons/presentation/widgets/lesson_pdf_reader_screen_widgets/lesson_pdf_state_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonPdfErrorView extends StatelessWidget {
  const LessonPdfErrorView({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  final String errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return LessonPdfStateLayout(
      child: Padding(
        padding: EdgeInsets.all(28.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.cloud_off_outlined,
              color: ColorPalette.primary,
              size: 42.sp,
            ),
            verticalSpace(16),
            Text(
              'تعذر تحميل الملف',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: AppTextStyle.font17TextPrimarySemiBoldKufam(),
            ),
            verticalSpace(8),
            Text(
              errorMessage,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: AppTextStyle.font14TextSecondaryRegularTajawal(),
            ),
            verticalSpace(18),
            FilledButton(
              onPressed: onRetry,
              style: FilledButton.styleFrom(
                backgroundColor: ColorPalette.primary,
              ),
              child: Text(
                'إعادة المحاولة',
                style: AppTextStyle.font14TextLightSemiBoldTajawal(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
