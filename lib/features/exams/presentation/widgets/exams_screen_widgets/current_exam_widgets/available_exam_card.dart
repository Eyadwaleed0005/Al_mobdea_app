import 'package:al_mobdea/core/helper/arabic_numbers_helper.dart';
import 'package:al_mobdea/core/helper/grade_name_helper.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/features/exams/domain/entities/student_exam_entity.dart';
import 'package:al_mobdea/features/exams/presentation/widgets/exams_screen_widgets/current_exam_widgets/exam_stat_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailableExamCard extends StatelessWidget {
  const AvailableExamCard({super.key, required this.exam});

  final StudentExamEntity exam;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Center(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: ColorPalette.wine50,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  exam.isPublished ? 'اختبار متاح الآن • متاح لصفك' : 'محاولتك الحالية',
                  style: AppTextStyle.font12Wine600BoldTajawal().copyWith(
                    color: ColorPalette.primary,
                  ),
                ),
                horizontalSpace(8),
                Container(
                  width: 8.r,
                  height: 8.r,
                  decoration: const BoxDecoration(
                    color: ColorPalette.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
        ),
        verticalSpace(20),
        Text(
          exam.examName,
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
          style: AppTextStyle.font22TextPrimaryBoldKufam(),
        ),
        verticalSpace(16),
        Text(
          GradeNameHelper.getGradeName(exam.gradeId),
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
          style: AppTextStyle.font14TextSecondaryRegularTajawal(),
        ),
        verticalSpace(24),
        Row(
          children: [
            Expanded(
              child: ExamStatItem(value: toArabicNumbers(exam.questionCount), label: 'سؤالًا'),
            ),
            horizontalSpace(12),
            Expanded(
              child: ExamStatItem(value: toArabicNumbers(exam.durationMinutes), label: 'دقيقة'),
            ),
            horizontalSpace(12),
            Expanded(
              child: ExamStatItem(value: toArabicNumbers(exam.totalScore), label: 'درجة'),
            ),
          ],
        ),
      ],
    );
  }
}
