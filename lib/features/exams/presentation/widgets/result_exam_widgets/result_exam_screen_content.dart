import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/background/background_student_layout.dart';
import 'package:al_mobdea/core/widgets/curved_app_bar.dart';
import 'package:al_mobdea/core/widgets/custom_button.dart';
import 'package:al_mobdea/features/exams/domain/entities/student_exam_result_entity.dart';
import 'package:al_mobdea/features/exams/presentation/widgets/result_exam_widgets/exam_submitted_details_card.dart';
import 'package:al_mobdea/features/exams/presentation/widgets/result_exam_widgets/exam_submitted_success_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultExamScreenContent extends StatelessWidget {
  const ResultExamScreenContent({super.key, required this.result});

  final StudentExamResultEntity result;

  @override
  Widget build(BuildContext context) {
    return BackgroundStudentLayout(
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const CurvedAppBar(title: 'تم تسليم الاختبار'),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    verticalSpace(10),
                    ExamSubmittedSuccessCard(examName: result.examName),
                    verticalSpace(28),
                    const ExamSubmittedDetailsCard(),
                    verticalSpace(16),
                    Text(
                      'نتائج الاختبارات العامة لا تظهر داخل تطبيق الطالب.',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: AppTextStyle.font13TextSecondaryRegularTajawal(),
                    ),
                    verticalSpace(28),
                    CustomButton(
                      text: 'العودة للامتحانات',
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      background: ColorPalette.primary,
                      foreground: ColorPalette.textLight,
                      borderRadius: 30,
                      height: 52.h,
                    ),
                    verticalSpace(20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
