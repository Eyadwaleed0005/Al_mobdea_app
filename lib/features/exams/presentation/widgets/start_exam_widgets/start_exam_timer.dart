import 'package:al_mobdea/core/helper/arabic_numbers_helper.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StartExamTimer extends StatelessWidget {
  const StartExamTimer({super.key, required this.remainingDuration});

  final Duration remainingDuration;

  @override
  Widget build(BuildContext context) {
    final bool isRunningOut = remainingDuration <= const Duration(minutes: 5);

    final Color foregroundColor = isRunningOut
        ? ColorPalette.error
        : ColorPalette.primary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.access_time_rounded, size: 20.sp, color: foregroundColor),
        horizontalSpace(6),
        Text(
          _formatDuration(remainingDuration),
          textDirection: TextDirection.ltr,
          style: AppTextStyle.font24PrimaryBoldKufam().copyWith(
            color: foregroundColor,
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    final int totalSeconds = duration.isNegative ? 0 : duration.inSeconds;

    final int hours = totalSeconds ~/ Duration.secondsPerHour;

    final int minutes =
        (totalSeconds % Duration.secondsPerHour) ~/ Duration.secondsPerMinute;

    final int seconds = totalSeconds % Duration.secondsPerMinute;

    if (hours == 0) {
      return '${toArabicNumbers(minutes).padLeft(2, '٠')}'
          ':${toArabicNumbers(seconds).padLeft(2, '٠')}';
    }

    return '${toArabicNumbers(hours).padLeft(2, '٠')}'
        ':${toArabicNumbers(minutes).padLeft(2, '٠')}'
        ':${toArabicNumbers(seconds).padLeft(2, '٠')}';
  }
}
