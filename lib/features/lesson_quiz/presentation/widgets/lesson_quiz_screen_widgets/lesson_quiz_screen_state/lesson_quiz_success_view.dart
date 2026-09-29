import 'package:al_mobdea/app/dependency_injection/service_locator.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/custom_button.dart';
import 'package:al_mobdea/core/widgets/custom_secondary_button.dart';
import 'package:al_mobdea/features/lesson_quiz/domain/entity/lesson_quiz_entity.dart';
import 'package:al_mobdea/features/lesson_quiz/domain/usecase/calculate_lesson_quiz_result_use_case.dart';
import 'package:al_mobdea/features/lesson_quiz/presentation/cubit/lesson_quiz_session_cubit.dart';
import 'package:al_mobdea/features/lesson_quiz/presentation/screens/lesson_quiz_result_screen.dart';
import 'package:al_mobdea/features/lesson_quiz/presentation/widgets/lesson_quiz_screen_widgets/lesson_quiz_screen_widget/quiz_answer_option.dart';
import 'package:al_mobdea/features/lesson_quiz/presentation/widgets/lesson_quiz_screen_widgets/lesson_quiz_screen_widget/quiz_auto_save_notice.dart';
import 'package:al_mobdea/features/lesson_quiz/presentation/widgets/lesson_quiz_screen_widgets/lesson_quiz_screen_widget/quiz_progress.dart';
import 'package:al_mobdea/features/lesson_quiz/presentation/widgets/lesson_quiz_screen_widgets/lesson_quiz_screen_widget/quiz_question_content_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonQuizSuccessView extends StatelessWidget {
  const LessonQuizSuccessView({super.key, required this.quiz});

  final LessonQuizEntity quiz;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return LessonQuizSessionCubit(
          quiz: quiz,
          calculateResultUseCase: getIt<CalculateLessonQuizResultUseCase>(),
        );
      },
      child: const _LessonQuizSessionContent(),
    );
  }
}

class _LessonQuizSessionContent extends StatelessWidget {
  const _LessonQuizSessionContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LessonQuizSessionCubit, LessonQuizSessionState>(
      builder: (context, state) {
        final sessionCubit = context.read<LessonQuizSessionCubit>();

        final question = state.currentQuestion;

        if (question == null) {
          return const SizedBox.shrink();
        }

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    verticalSpace(18),
                    QuizProgress(
                      current: state.currentIndex + 1,
                      total: state.quiz.questions.length,
                      totalScore: state.quiz.totalScore,
                    ),
                    verticalSpace(28),
                    QuizQuestionContentCard(questionText: question.questionText),
                    verticalSpace(24),
                    ...List.generate(question.options.length, (int index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: QuizAnswerOption(
                          title: question.options[index],
                          isSelected: state.currentSelectedOption == index,
                          onTap: () {
                            sessionCubit.selectAnswer(
                              questionId: question.questionId,
                              optionIndex: index,
                            );
                          },
                        ),
                      );
                    }),
                    verticalSpace(12),
                    const QuizAutoSaveNotice(),
                    verticalSpace(18),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
              child: _buildNavigationActions(
                context: context,
                sessionCubit: sessionCubit,
                state: state,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNavigationActions({
    required BuildContext context,
    required LessonQuizSessionCubit sessionCubit,
    required LessonQuizSessionState state,
  }) {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        if (!state.isFirstQuestion) ...[
          Expanded(
            flex: 4,
            child: CustomSecondaryButton(
              text: 'السابق',
              onPressed: sessionCubit.previousQuestion,
              backgroundColor: ColorPalette.surface,
              borderColor: ColorPalette.border,
              borderWidth: 1.2,
              foregroundColor: ColorPalette.textPrimary,
              textStyle: AppTextStyle.font14TextPrimaryBoldTajawal(),
              borderRadius: 30,
              height: 48.h,
            ),
          ),
          horizontalSpace(10),
        ],
        Expanded(
          flex: state.isFirstQuestion ? 1 : 6,
          child: CustomButton(
            text: state.isLastQuestion ? 'تسليم الاختبار' : '← التالي',
            onPressed: !state.isCurrentQuestionAnswered
                ? null
                : () {
                    _handleNextAction(
                      context: context,
                      sessionCubit: sessionCubit,
                      isLastQuestion: state.isLastQuestion,
                    );
                  },
            background: ColorPalette.primary,
            foreground: ColorPalette.textLight,
            textStyle: AppTextStyle.font14TextLightBoldTajawal(),
            borderRadius: 30,
            height: 48.h,
          ),
        ),
      ],
    );
  }

  void _handleNextAction({
    required BuildContext context,
    required LessonQuizSessionCubit sessionCubit,
    required bool isLastQuestion,
  }) {
    if (!isLastQuestion) {
      sessionCubit.nextQuestion();
      return;
    }

    sessionCubit.submitQuiz();

    final sessionState = sessionCubit.state;

    if (!sessionState.isSubmitted || sessionState.result == null) {
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) {
          return BlocProvider.value(value: sessionCubit, child: const LessonQuizResultScreen());
        },
      ),
    );
  }
}
