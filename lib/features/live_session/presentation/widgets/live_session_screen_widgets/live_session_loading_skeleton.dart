import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LiveSessionLoadingSkeleton extends StatelessWidget {
  const LiveSessionLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          decoration: BoxDecoration(
            color: ColorPalette.surface,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: ColorPalette.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  const Expanded(child: _SkeletonBar(width: 176, height: 25)),
                  horizontalSpace(14),
                  const _SkeletonBar(width: 76, height: 32, radius: 22),
                ],
              ),
              verticalSpace(14),
              const _SkeletonBar(width: 230, height: 16),
              verticalSpace(30),
              const _SkeletonBar(width: double.infinity, height: 60, radius: 16),
            ],
          ),
        )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(
          duration: 1400.ms,
          color: ColorPalette.wine50.withValues(alpha: 0.8),
        );
  }
}

class _SkeletonBar extends StatelessWidget {
  const _SkeletonBar({
    required this.width,
    required this.height,
    this.radius = 6,
  });

  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width == double.infinity ? null : width.w,
      height: height.h,
      decoration: BoxDecoration(
        color: ColorPalette.wine50,
        borderRadius: BorderRadius.circular(radius.r),
      ),
    );
  }
}
