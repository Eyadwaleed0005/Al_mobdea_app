import 'package:al_mobdea/app/routes/screen_routes/route_names.dart';
import 'package:al_mobdea/core/helper/arabic_numbers_helper.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/background/background_student_layout.dart';
import 'package:al_mobdea/core/widgets/custom_button.dart';
import 'package:al_mobdea/core/widgets/custom_secondary_button.dart';
import 'package:al_mobdea/features/lesson_quiz/presentation/cubit/lesson_quiz_session_cubit.dart';
import 'package:al_mobdea/features/lesson_quiz/presentation/screens/lesson_quiz_review_screen.dart';
import 'package:al_mobdea/features/lesson_quiz/presentation/widgets/lesson_quiz_result_screen_widgets/quiz_result_card.dart';
import 'package:al_mobdea/features/lesson_quiz/presentation/widgets/lesson_quiz_screen_widgets/lesson_quiz_screen_widget/lesson_quiz_app_bar.dart';
import 'package:al_mobdea/features/lesson_quiz/presentation/widgets/lesson_quiz_screen_widgets/lesson_quiz_screen_widget/quiz_info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonQuizResultScreenContent extends StatelessWidget {
  const LessonQuizResultScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonQuizSessionCubit, LessonQuizSessionState>(
      builder: (context, state) {
        final result = state.result;

        return BackgroundStudentLayout(
          child: SafeArea(
            child: Scaffold(
              backgroundColor: ColorPalette.background,
              appBar: LessonQuizAppBar(
                title: 'نتيجة اختبار الدرس',
                onBack: () {
                  _returnToLessonDetails(context);
                },
              ),
              body: result == null
                  ? Center(
                      child: Text(
                        'تعذر عرض نتيجة الاختبار.',
                        textDirection: TextDirection.rtl,
                        style: AppTextStyle.font14TextSecondaryRegularTajawal(),
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                verticalSpace(12),
                                QuizResultCard(result: result),
                                verticalSpace(24),
                                QuizInfoCard(
                                  scoreText:
                                      '${toArabicNumbers(result.earnedScore)} من '
                                      '${toArabicNumbers(result.totalScore)}',
                                  retryText: 'متاحة',
                                ),
                                verticalSpace(16),
                                Text(
                                  'يمكنك إعادة الاختبار لتحسين درجتك.',
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: AppTextStyle.font12TextSecondaryRegularTajawal(),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomButton(
                                text: 'إعادة الاختبار',
                                onPressed: () {
                                  _restartQuiz(context);
                                },
                                background: ColorPalette.primary,
                                foreground: ColorPalette.textLight,
                                textStyle: AppTextStyle.font14TextLightBoldTajawal(),
                                borderRadius: 30,
                                height: 48.h,
                              ),
                              verticalSpace(10),
                              CustomSecondaryButton(
                                text: 'مراجعة الإجابات',
                                onPressed: () {
                                  _openReviewScreen(context);
                                },
                                backgroundColor: ColorPalette.surface,
                                borderColor: ColorPalette.border,
                                borderWidth: 1.2,
                                foregroundColor: ColorPalette.textPrimary,
                                textStyle: AppTextStyle.font14TextPrimaryBoldTajawal(),
                                borderRadius: 30,
                                height: 48.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  void _returnToLessonDetails(BuildContext context) {
    Navigator.of(context).popUntil((route) {
      return route.settings.name == RouteNames.lessonDetails || route.isFirst;
    });
  }

  void _openReviewScreen(BuildContext context) {
    final sessionCubit = context.read<LessonQuizSessionCubit>();

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) {
          return BlocProvider.value(value: sessionCubit, child: const LessonQuizReviewScreen());
        },
      ),
    );
  }

  void _restartQuiz(BuildContext context) {
    context.read<LessonQuizSessionCubit>().restartQuiz();
    Navigator.of(context).pop();
  }
}
