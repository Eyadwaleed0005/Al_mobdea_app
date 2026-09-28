import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamSubmittedSuccessCard extends StatelessWidget {
  const ExamSubmittedSuccessCard({
    super.key,
    required this.examName,
    this.title = 'تم تسليم الاختبار بنجاح',
    this.noticeText = 'تم حفظ إجاباتك وإرسالها للمدرس للمراجعة.',
  });

  final String examName;
  final String title;
  final String noticeText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 90.r,
          height: 90.r,
          decoration: const BoxDecoration(color: Color(0xFFFBF2F3), shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Icon(Icons.check, size: 46.sp, color: ColorPalette.primary),
        ),
        verticalSpace(24),
        Text(
          title,
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: AppTextStyle.font22TextPrimaryBoldKufam(),
        ),
        verticalSpace(8),
        Text(
          examName,
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: AppTextStyle.font14TextSecondaryRegularTajawal(),
        ),
        verticalSpace(4),
        Text(
          noticeText,
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: AppTextStyle.font14TextSecondaryRegularTajawal(),
        ),
      ],
    );
  }
}
