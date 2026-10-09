import 'package:al_mobdea/core/helper/arabic_numbers_helper.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/features/exams/presentation/widgets/start_exam_widgets/exam_answer_option_tile.dart';
import 'package:al_mobdea/features/exams/presentation/widgets/start_exam_widgets/image_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamQuestionCard extends StatelessWidget {
  const ExamQuestionCard({
    super.key,
    required this.questionIndex,
    required this.questionText,
    required this.options,
    required this.selectedIndex,
    required this.onOptionSelected,
    this.imageQuestion,
    this.isEnabled = true,
  });

  final int questionIndex;
  final String questionText;
  final String? imageQuestion;
  final List<String> options;
  final int? selectedIndex;
  final ValueChanged<int> onOptionSelected;
  final bool isEnabled;

  bool get _hasImage => imageQuestion?.trim().isNotEmpty == true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Question Container Card
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          decoration: BoxDecoration(
            color: ColorPalette.surface,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(
              color: ColorPalette.borderWarm.withValues(alpha: 0.6),
              width: 1.w,
            ),
            boxShadow: [
              BoxShadow(
                color: ColorPalette.cardShadow.withValues(alpha: 0.04),
                blurRadius: 16.r,
                offset: Offset(0, 4.h),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Question index pill label on the right
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'سؤال ${toArabicNumbers(questionIndex)}',
                  textDirection: TextDirection.rtl,
                  style: AppTextStyle.font14PrimaryMediumTajawal(),
                ),
              ),
              verticalSpace(14),
              // Question text
              Text(
                questionText,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
                style: AppTextStyle.font18TextPrimaryBoldKufam(),
              ),
              if (_hasImage) ...[
                verticalSpace(16),
                ImageQuestion(image: imageQuestion!),
              ],
            ],
          ),
        ),
        verticalSpace(20),
        // Prompt
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'اختار إجابة واحدة',
            textDirection: TextDirection.rtl,
            style: AppTextStyle.font14TextSecondaryRegularTajawal(),
          ),
        ),
        verticalSpace(12),
        // Options List
        IgnorePointer(
          ignoring: !isEnabled,
          child: Opacity(
            opacity: isEnabled ? 1 : 0.65,
            child: Column(
              children: List<Widget>.generate(options.length, (int index) {
                return ExamAnswerOptionTile(
                  text: options[index],
                  isSelected: selectedIndex == index,
                  onTap: () {
                    onOptionSelected(index);
                  },
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
