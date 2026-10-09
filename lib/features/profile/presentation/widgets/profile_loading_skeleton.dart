import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileLoadingSkeleton extends StatelessWidget {
  const ProfileLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _SkeletonBox(width: 120.w, height: 24.h),
        verticalSpace(6),
        _SkeletonBox(width: 190.w, height: 14.h),
        verticalSpace(24),
        _SkeletonBox(
          width: double.infinity,
          height: 180.h,
          borderRadius: BorderRadius.circular(28.r),
          color: ColorPalette.primary.withValues(alpha: 0.16),
        ),
        verticalSpace(28),
        _SkeletonBox(width: 90.w, height: 20.h),
        verticalSpace(12),
        _SkeletonBox(
          width: double.infinity,
          height: 260.h,
          borderRadius: BorderRadius.circular(24.r),
        ),
        verticalSpace(28),
        _SkeletonBox(
          width: double.infinity,
          height: 54.h,
          borderRadius: BorderRadius.circular(20.r),
        ),
      ],
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  const _SkeletonBox({required this.width, required this.height, this.borderRadius, this.color});

  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? ColorPalette.wine50,
        borderRadius: borderRadius ?? BorderRadius.circular(8.r),
      ),
    );
  }
}
