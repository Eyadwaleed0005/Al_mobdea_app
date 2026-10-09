import 'dart:async';

import 'package:al_mobdea/app/routes/screen_routes/route_names.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/widgets/app_error_state.dart';
import 'package:al_mobdea/core/widgets/app_loading_indicator.dart';
import 'package:al_mobdea/core/widgets/background/background_student_layout.dart';
import 'package:al_mobdea/core/widgets/curved_app_bar.dart';
import 'package:al_mobdea/core/widgets/custom_dialog.dart';
import 'package:al_mobdea/core/widgets/custom_operation_result_dialog.dart';
import 'package:al_mobdea/features/exams/presentation/cubit/pending_exam_submissions_sync_cubit.dart';
import 'package:al_mobdea/features/exams/presentation/cubit/start_exam_screen_cubit.dart';
import 'package:al_mobdea/features/exams/presentation/widgets/start_exam_widgets/exam_navigation_actions.dart';
import 'package:al_mobdea/features/exams/presentation/widgets/start_exam_widgets/exam_question_card.dart';
import 'package:al_mobdea/features/exams/presentation/widgets/start_exam_widgets/finish_exam_confirmation_dialog.dart';
import 'package:al_mobdea/features/exams/presentation/widgets/start_exam_widgets/start_exam_progress_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartExamScreenContent extends StatefulWidget {
  const StartExamScreenContent({super.key});

  @override
  State<StartExamScreenContent> createState() => _StartExamScreenContentState();
}

class _StartExamScreenContentState extends State<StartExamScreenContent> {
  late final PageController _pageController;

  PendingExamSubmissionsSyncCubit? _pendingSubmissionsSyncCubit;

  bool _isFinishDialogVisible = false;
  bool _isFailureDialogVisible = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_pendingSubmissionsSyncCubit != null) {
      return;
    }

    final PendingExamSubmissionsSyncCubit syncCubit = context
        .read<PendingExamSubmissionsSyncCubit>();
    _pendingSubmissionsSyncCubit = syncCubit;
    syncCubit.pauseAutomaticSync();
  }

  @override
  void dispose() {
    _pendingSubmissionsSyncCubit?.resumeAutomaticSync();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StartExamScreenCubit, StartExamScreenState>(
      listenWhen: (previous, current) {
        return current is StartExamScreenActionFailure || current is StartExamScreenResultReady;
      },
      listener: _handleStateListener,
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, StartExamScreenState state) {
    if (state is StartExamScreenInitial ||
        state is StartExamScreenLoading ||
        state is StartExamScreenResultReady) {
      return const BackgroundStudentLayout(
        child: SafeArea(
          bottom: false,
          child: Center(
            child: AppLoadingIndicator(
              color: ColorPalette.primary,
              size: 34,
              strokeWidth: 4,
              wavelength: 16,
              waveSpeed: 10,
            ),
          ),
        ),
      );
    }

    if (state is StartExamScreenFailure) {
      return BackgroundStudentLayout(
        child: SafeArea(
          bottom: false,
          child: AppErrorState(
            message: state.error.message,
            onRetry: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      );
    }

    if (state is StartExamScreenDataState) {
      return _buildExamContent(context: context, state: state);
    }

    return const SizedBox.shrink();
  }

  Widget _buildExamContent({
    required BuildContext context,
    required StartExamScreenDataState state,
  }) {
    final bool isSubmitting = state is StartExamScreenSubmitting;
    final cubit = context.read<StartExamScreenCubit>();

    final bool canInteract =
        !isSubmitting &&
        !state.isTimeExpired &&
        !state.cachedAttempt.isPendingSubmission &&
        !state.cachedAttempt.isSubmissionStopped;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) return;
        _showFinishExamDialog(context: context, state: state);
      },
      child: BackgroundStudentLayout(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              CurvedAppBar(
                title: state.session.exam.examName,
                onBack: () {
                  _showFinishExamDialog(context: context, state: state);
                },
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      verticalSpace(12),
                      StartExamProgressHeader(
                        currentQuestion: state.currentQuestionIndex + 1,
                        totalQuestions: state.totalQuestionsCount,
                        completionPercentage: state.completionPercentage,
                        remainingDuration: state.remainingDuration,
                      ),
                      verticalSpace(16),
                      Expanded(
                        child: IgnorePointer(
                          ignoring: !canInteract,
                          child: Opacity(
                            opacity: canInteract ? 1 : 0.65,
                            child: PageView.builder(
                              controller: _pageController,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.session.questions.length,
                              itemBuilder: (context, index) {
                                final question = state.session.questions[index];
                                final selectedIndex = state.selectedChoiceIndexFor(
                                  question.questionId,
                                );

                                return SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  padding: EdgeInsets.only(bottom: 16.h),
                                  child: ExamQuestionCard(
                                    questionIndex: index + 1,
                                    questionText: question.questionText,
                                    imageQuestion: question.questionImageUrl,
                                    options: question.choices,
                                    selectedIndex: selectedIndex,
                                    isEnabled: canInteract,
                                    onOptionSelected: (int choiceIndex) {
                                      final int? updatedChoiceIndex = selectedIndex == choiceIndex
                                          ? null
                                          : choiceIndex;

                                      unawaited(
                                        cubit.saveAnswer(
                                          questionId: question.questionId,
                                          selectedChoiceIndex: updatedChoiceIndex,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      verticalSpace(12),
                      ExamNavigationActions(
                        isSubmitting: isSubmitting,
                        onPreviousPressed: canInteract && !state.isFirstQuestion
                            ? () {
                                _handleNavigateToQuestion(index: state.currentQuestionIndex - 1);
                              }
                            : null,
                        onNextPressed: canInteract && !state.isLastQuestion
                            ? () {
                                _handleNavigateToQuestion(index: state.currentQuestionIndex + 1);
                              }
                            : null,
                        onSubmitPressed: canInteract
                            ? () {
                                unawaited(_showFinishExamDialog(context: context, state: state));
                              }
                            : null,
                      ),
                      verticalSpace(26),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleNavigateToQuestion({required int index}) {
    context.read<StartExamScreenCubit>().changeQuestion(index);
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  void _handleStateListener(BuildContext context, StartExamScreenState state) {
    if (state is StartExamScreenResultReady) {
      Navigator.of(context)
          .pushReplacementNamed(RouteNames.resultExamScreen, arguments: state.result);
      return;
    }

    if (state is StartExamScreenActionFailure) {
      _showActionFailureDialog(context: context, state: state);
    }
  }

  Future<void> _showFinishExamDialog({
    required BuildContext context,
    required StartExamScreenDataState state,
  }) async {
    if (_isFinishDialogVisible ||
        state.isTimeExpired ||
        state.cachedAttempt.isPendingSubmission ||
        state.cachedAttempt.isSubmissionStopped) {
      return;
    }

    _isFinishDialogVisible = true;

    final cubit = context.read<StartExamScreenCubit>();

    try {
      await FinishExamConfirmationDialog.show(
        context,
        answeredCount: state.answeredQuestionsCount,
        totalQuestions: state.totalQuestionsCount,
        onConfirmFinish: () {
          if (!cubit.isClosed) {
            unawaited(cubit.submitExam(isAutomatic: false));
          }
        },
      );
    } finally {
      _isFinishDialogVisible = false;
    }
  }

  Future<void> _showActionFailureDialog({
    required BuildContext context,
    required StartExamScreenActionFailure state,
  }) async {
    if (_isFailureDialogVisible) return;
    _isFailureDialogVisible = true;

    final cubit = context.read<StartExamScreenCubit>();

    final bool isExamDeleted =
        state.isSubmissionFailure && state.error.code == 'exam-deleted';

    bool? shouldRetry;

    try {
      shouldRetry = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return PopScope(
            canPop: false,
            child: CustomOperationResultDialog(
              type: CustomOperationResultType.failure,
              title: isExamDeleted
                  ? 'تم حذف الاختبار'
                  : state.isSubmissionFailure
                  ? 'تعذر تسليم الاختبار'
                  : 'تعذر حفظ الإجابة',
              message: state.error.message,
              actionText: isExamDeleted
                  ? 'حسنًا'
                  : state.isSubmissionFailure
                  ? 'إعادة المحاولة'
                  : 'حسنًا',
              secondaryActionText: state.isSubmissionFailure && !isExamDeleted
                  ? 'المحاولة لاحقًا'
                  : null,
              onActionPressed: () {
                Navigator.of(
                  dialogContext,
                ).pop(state.isSubmissionFailure && !isExamDeleted);
              },
              onSecondaryActionPressed:
                  state.isSubmissionFailure && !isExamDeleted
                  ? () {
                      unawaited(
                        _confirmAttemptLater(
                          failureDialogContext: dialogContext,
                        ),
                      );
                    }
                  : null,
            ),
          );
        },
      );
    } finally {
      _isFailureDialogVisible = false;
    }

    if (!mounted || cubit.isClosed) return;

    if (isExamDeleted) {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop<String>(state.session.exam.examId);
      }
      return;
    }

    if (!state.isSubmissionFailure) {
      cubit.restoreExamState();
      return;
    }

    if (shouldRetry == true) {
      await cubit.submitExam(isAutomatic: state.isTimeExpired);
      return;
    }

    if (!context.mounted) return;

    if (shouldRetry == false && Navigator.of(context).canPop()) {
      Navigator.of(context).pop<String>(state.session.exam.examId);
    }
  }

  Future<void> _confirmAttemptLater({required BuildContext failureDialogContext}) async {
    if (!failureDialogContext.mounted) return;

    final bool? isConfirmed = await CustomDialog.showConfirm(
      failureDialogContext,
      title: 'المحاولة لاحقًا',
      message:
          'سيتم إرسال إجاباتك تلقائيًا عند إمكانية الإرسال، '
          'لكن لن تتمكن من معرفة النتيجة من داخل التطبيق. '
          'لمعرفة النتيجة تواصل مع المعلم.',
      primaryText: 'المحاولة لاحقًا',
      secondaryText: 'العودة',
      icon: Icons.info_outline_rounded,
    );

    if (isConfirmed != true || !failureDialogContext.mounted) return;
    Navigator.of(failureDialogContext).pop(false);
  }
}
