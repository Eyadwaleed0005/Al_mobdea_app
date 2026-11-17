import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LiveSessionLoadingSkeleton extends StatelessWidget {
  const LiveSessionLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.h),
        decoration: BoxDecoration(
          color: ColorPalette.surface,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: ColorPalette.border),
          boxShadow: [
            BoxShadow(
              color: ColorPalette.cardShadow.withValues(alpha: 0.07),
              blurRadius: 18.r,
              offset: Offset(0, 8.h),
            ),
          ],
        ),
        child: Shimmer.fromColors(
          baseColor: const Color(0xFFE0E0E0),
          highlightColor: const Color(0xFFF5F5F5),
          direction: ShimmerDirection.rtl,
          period: const Duration(milliseconds: 1400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: _SkeletonBar(width: 176.w, height: 25.h),
                    ),
                  ),
                  horizontalSpace(12),
                  _SkeletonBar(width: 76.w, height: 32.h, radius: 22.r),
                ],
              ),
              verticalSpace(12),
              FractionallySizedBox(
                widthFactor: 0.85,
                alignment: Alignment.centerRight,
                child: _SkeletonBar(height: 16.h),
              ),
              verticalSpace(28),
              _SkeletonBar(height: 60.h, radius: 16.r),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkeletonBar extends StatelessWidget {
  const _SkeletonBar({required this.height, this.width, this.radius});

  final double? width;
  final double height;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius ?? 6.r),
        ),
      ),
    );
  }
}
