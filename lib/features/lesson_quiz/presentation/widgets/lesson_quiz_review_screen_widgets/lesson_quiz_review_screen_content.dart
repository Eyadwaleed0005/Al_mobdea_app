import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/background/background_student_layout.dart';
import 'package:al_mobdea/features/lesson_quiz/presentation/cubit/lesson_quiz_session_cubit.dart';
import 'package:al_mobdea/features/lesson_quiz/presentation/widgets/lesson_quiz_review_screen_widgets/quiz_review_navigation.dart';
import 'package:al_mobdea/features/lesson_quiz/presentation/widgets/lesson_quiz_screen_widgets/lesson_quiz_screen_widget/lesson_quiz_app_bar.dart';
import 'package:al_mobdea/features/lesson_quiz/presentation/widgets/lesson_quiz_screen_widgets/lesson_quiz_screen_widget/quiz_answer_option.dart';
import 'package:al_mobdea/features/lesson_quiz/presentation/widgets/lesson_quiz_screen_widgets/lesson_quiz_screen_widget/quiz_progress.dart';
import 'package:al_mobdea/features/lesson_quiz/presentation/widgets/lesson_quiz_screen_widgets/lesson_quiz_screen_widget/quiz_question_content_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonQuizReviewScreenContent extends StatefulWidget {
  const LessonQuizReviewScreenContent({super.key});

  @override
  State<LessonQuizReviewScreenContent> createState() {
    return _LessonQuizReviewScreenContentState();
  }
}

class _LessonQuizReviewScreenContentState extends State<LessonQuizReviewScreenContent> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonQuizSessionCubit, LessonQuizSessionState>(
      builder: (context, state) {
        final questions = state.quiz.questions;

        if (questions.isEmpty) {
          return const BackgroundStudentLayout(
            child: Center(child: Text('لا توجد أسئلة للمراجعة.', textDirection: TextDirection.rtl)),
          );
        }

        final question = questions[_currentIndex];
        final selectedOptionIndex = state.selectedAnswers[question.questionId];

        final isCorrect = selectedOptionIndex == question.correctOptionIndex;

        final isFirstQuestion = _currentIndex == 0;
        final isLastQuestion = _currentIndex == questions.length - 1;

        return BackgroundStudentLayout(
          child: SafeArea(
            bottom: false,
            child: Scaffold(
              backgroundColor: ColorPalette.background,
              appBar: LessonQuizAppBar(title: 'مراجعة الإجابات'),
              body: SafeArea(
                top: false,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            verticalSpace(6),
                            QuizProgress(
                              current: _currentIndex + 1,
                              total: questions.length,
                              totalScore: state.quiz.totalScore,
                              statusText: isCorrect ? 'إجابة صحيحة' : 'إجابة خاطئة',
                              statusColor: isCorrect ? ColorPalette.success : ColorPalette.error,
                            ),
                            verticalSpace(28),
                            QuizQuestionContentCard(questionText: question.questionText),
                            verticalSpace(16),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                isCorrect ? 'إجابة صحيحة' : 'إجابة خاطئة',
                                textDirection: TextDirection.rtl,
                                style: AppTextStyle.font14ErrorSemiBoldTajawal().copyWith(
                                  color: isCorrect ? ColorPalette.success : ColorPalette.error,
                                ),
                              ),
                            ),
                            verticalSpace(12),
                            ...List.generate(question.options.length, (int index) {
                              final bool isOptionCorrect = index == question.correctOptionIndex;

                              return Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
                                child: QuizAnswerOption(
                                  title: question.options[index],
                                  isCorrect: isOptionCorrect ? true : null,
                                ),
                              );
                            }),
                            verticalSpace(12),
                            if (!isCorrect)
                              Text(
                                'الإجابة الصحيحة موضحة باللون الأخضر.',
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
                      child: QuizReviewNavigation(
                        isFirstQuestion: isFirstQuestion,
                        isLastQuestion: isLastQuestion,
                        onPrevious: () {
                          _handlePrevious(isFirstQuestion: isFirstQuestion);
                        },
                        onNext: () {
                          _handleNext(isLastQuestion: isLastQuestion);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _handlePrevious({required bool isFirstQuestion}) {
    if (isFirstQuestion) {
      Navigator.of(context).pop();
      return;
    }

    setState(() {
      _currentIndex--;
    });
  }

  void _handleNext({required bool isLastQuestion}) {
    if (isLastQuestion) {
      Navigator.of(context).pop();
      return;
    }

    setState(() {
      _currentIndex++;
    });
  }
}
