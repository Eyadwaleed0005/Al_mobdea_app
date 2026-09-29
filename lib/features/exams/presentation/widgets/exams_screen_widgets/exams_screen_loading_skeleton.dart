import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamsScreenLoadingSkeleton extends StatefulWidget {
  const ExamsScreenLoadingSkeleton({super.key});

  @override
  State<ExamsScreenLoadingSkeleton> createState() {
    return _ExamsScreenLoadingSkeletonState();
  }
}

class _ExamsScreenLoadingSkeletonState extends State<ExamsScreenLoadingSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1300),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            verticalSpace(20),
            _buildExamCardSkeleton(),
            verticalSpace(24),
            _buildCountdownNoticeSkeleton(),
          ],
        );
      },
    );
  }

  Widget _buildExamCardSkeleton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: ColorPalette.surface,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: ColorPalette.borderWarm.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: ColorPalette.cardShadow.withValues(alpha: 0.04),
            blurRadius: 16.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Column(
        children: [
          Center(
            child: _buildSkeletonBox(
              width: 170.w,
              height: 28.h,
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
          verticalSpace(20),
          _buildSkeletonBox(
            width: 200.w,
            height: 24.h,
            borderRadius: BorderRadius.circular(8.r),
          ),
          verticalSpace(10),
          _buildSkeletonBox(
            width: 120.w,
            height: 14.h,
            borderRadius: BorderRadius.circular(6.r),
          ),
          verticalSpace(24),
          Row(
            children: [
              Expanded(child: _buildExamStatSkeleton()),
              horizontalSpace(12),
              Expanded(child: _buildExamStatSkeleton()),
              horizontalSpace(12),
              Expanded(child: _buildExamStatSkeleton()),
            ],
          ),
          verticalSpace(24),
          _buildSkeletonBox(
            height: 52.h,
            borderRadius: BorderRadius.circular(30.r),
          ),
        ],
      ),
    );
  }

  Widget _buildExamStatSkeleton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: ColorPalette.cardFillSoft,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          _buildSkeletonBox(
            width: 32.w,
            height: 18.h,
            borderRadius: BorderRadius.circular(6.r),
          ),
          verticalSpace(6),
          _buildSkeletonBox(
            width: 44.w,
            height: 12.h,
            borderRadius: BorderRadius.circular(5.r),
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownNoticeSkeleton() {
    return Center(
      child: _buildSkeletonBox(
        width: 180.w,
        height: 14.h,
        borderRadius: BorderRadius.circular(6.r),
      ),
    );
  }

  Widget _buildSkeletonBox({
    double? width,
    required double height,
    BorderRadius? borderRadius,
  }) {
    final double movement = _animationController.value * 3;

    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(8.r),
        gradient: LinearGradient(
          begin: Alignment(-1.5 + movement, 0),
          end: Alignment(-0.5 + movement, 0),
          colors: const [
            ColorPalette.cream200,
            ColorPalette.cream50,
            ColorPalette.cream200,
          ],
          stops: const [0.2, 0.5, 0.8],
        ),
      ),
    );
  }
}
