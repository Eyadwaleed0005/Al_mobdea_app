import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LessonsLoadingSkeleton extends StatelessWidget {
  const LessonsLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorPalette.wine50,
      highlightColor: ColorPalette.surface,
      child: ListView.separated(
        padding: EdgeInsets.only(bottom: 112.h),
        itemCount: 4,
        separatorBuilder: (_, _) => verticalSpace(22),
        itemBuilder: (_, _) => Container(
          height: 106.h,
          decoration: BoxDecoration(
            color: ColorPalette.surface,
            borderRadius: BorderRadius.circular(22.r),
          ),
        ),
      ),
    );
  }
}
