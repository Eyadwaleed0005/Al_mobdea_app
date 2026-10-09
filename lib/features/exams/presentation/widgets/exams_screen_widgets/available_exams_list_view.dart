import 'dart:async';

import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_animations.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/app_loading_indicator.dart';
import 'package:al_mobdea/core/widgets/custom_button.dart';
import 'package:al_mobdea/features/exams/domain/entities/student_exam_list_item_entity.dart';
import 'package:al_mobdea/features/exams/presentation/widgets/exams_screen_widgets/current_exam_widgets/available_exam_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailableExamsListView extends StatefulWidget {
  const AvailableExamsListView({
    super.key,
    required this.exams,
    required this.onExamPressed,
    this.openingExamId,
  });

  final List<StudentExamListItemEntity> exams;
  final ValueChanged<StudentExamListItemEntity> onExamPressed;
  final String? openingExamId;

  @override
  State<AvailableExamsListView> createState() => _AvailableExamsListViewState();
}

class _AvailableExamsListViewState extends State<AvailableExamsListView> {
  Timer? _expiryTimer;

  @override
  void initState() {
    super.initState();
    _scheduleExpiryUpdate();
  }

  @override
  void didUpdateWidget(covariant AvailableExamsListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _scheduleExpiryUpdate();
  }

  void _scheduleExpiryUpdate() {
    _expiryTimer?.cancel();
    _expiryTimer = null;

    final DateTime now = DateTime.now().toUtc();
    DateTime? nextExpiry;

    for (final StudentExamListItemEntity examItem in widget.exams) {
      final attempt = examItem.attempt;

      if (attempt == null || !attempt.canContinueAt(now)) {
        continue;
      }

      final DateTime expiresAt = attempt.expiresAt.toUtc();

      if (nextExpiry == null || expiresAt.isBefore(nextExpiry)) {
        nextExpiry = expiresAt;
      }
    }

    if (nextExpiry == null) {
      return;
    }

    _expiryTimer = Timer(nextExpiry.difference(now), () {
      if (!mounted) {
        return;
      }

      setState(() {});
      _scheduleExpiryUpdate();
    });
  }

  void _handleExamPressed(StudentExamListItemEntity examItem) {
    if (widget.openingExamId != null) {
      return;
    }

    final DateTime now = DateTime.now().toUtc();

    if (!examItem.canStart && !examItem.canContinueAt(now)) {
      setState(() {});
      _scheduleExpiryUpdate();
      return;
    }

    widget.onExamPressed(examItem);
  }

  @override
  void dispose() {
    _expiryTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = DateTime.now().toUtc();

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      itemCount: widget.exams.length,
      separatorBuilder: (_, _) => verticalSpace(24),
      itemBuilder: (BuildContext context, int index) {
        final examItem = widget.exams[index];

        final isOpening =
            widget.openingExamId?.trim() == examItem.exam.examId.trim();

        final anotherExamIsOpening = widget.openingExamId != null && !isOpening;

        final shouldAutoSubmit = examItem.shouldAutoSubmitAt(currentDate);

        final canOpen =
            examItem.canStart || examItem.canContinueAt(currentDate);

        final canPress = !isOpening && !anotherExamIsOpening && canOpen;

        final buttonText = _buttonText(
          examItem: examItem,
          shouldAutoSubmit: shouldAutoSubmit,
        );
        final buttonOpacity = isOpening || canPress ? 1.0 : 0.65;
        final remainingDuration = _calculateClosingDuration(examItem, currentDate);
        final countdownText = remainingDuration == null
            ? null
            : _formatClosingTime(remainingDuration);

        return AppAnimations.screenSection(
          delay: 150 + (index * 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
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
                    AvailableExamCard(exam: examItem.exam),
                    verticalSpace(24),
                    IgnorePointer(
                      ignoring: !canPress,
                      child: Opacity(
                        opacity: buttonOpacity,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomButton(
                              text: isOpening ? '' : buttonText,
                              textStyle: AppTextStyle.font16TextLightBoldTajawal(),
                              onPressed: () {
                                _handleExamPressed(examItem);
                              },
                              background: ColorPalette.primary,
                              foreground: ColorPalette.textLight,
                              height: 52.h,
                              borderRadius: 30,
                            ),
                            if (isOpening)
                              const Positioned.fill(
                                child: Center(
                                  child: AppLoadingIndicator(
                                    color: ColorPalette.surface,
                                    size: 24,
                                    strokeWidth: 3,
                                    wavelength: 12,
                                    waveSpeed: 10,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (countdownText != null) ...[
                verticalSpace(14),
                Center(
                  child: Text(
                    countdownText,
                    textDirection: TextDirection.rtl,
                    style: AppTextStyle.font14PrimaryMediumTajawal(),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Duration? _calculateClosingDuration(StudentExamListItemEntity examItem, DateTime currentDate) {
    final attempt = examItem.attempt;

    if (attempt == null || !attempt.isInProgress) {
      return null;
    }

    return attempt.remainingDurationAt(currentDate);
  }

  String _formatClosingTime(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return 'يغلق الامتحان بعد $hours:$minutes:$seconds';
  }

  String _buttonText({
    required StudentExamListItemEntity examItem,
    required bool shouldAutoSubmit,
  }) {
    if (shouldAutoSubmit) return 'بانتظار تسليم الاختبار';
    if (examItem.hasAttempt) return 'استمرار الاختبار';
    return examItem.canStart ? 'ابدأ الامتحان' : 'الاختبار غير متاح';
  }
}
