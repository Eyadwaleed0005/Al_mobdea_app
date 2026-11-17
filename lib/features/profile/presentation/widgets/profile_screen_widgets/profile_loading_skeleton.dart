import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileLoadingSkeleton extends StatelessWidget {
  const ProfileLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        verticalSpace(12),
        Text(
          'حسابي',
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
          style: AppTextStyle.font24TextPrimarySemiBoldKufam(),
        ),
        verticalSpace(20),
        _buildStudentCard(),
        verticalSpace(28),
        Align(
          alignment: Alignment.centerRight,
          child: _SkeletonBox(width: 70.w, height: 20.h),
        ),
        verticalSpace(12),
        for (var index = 0; index < 4; index++) ...[
          _buildActionCard(),
          if (index != 3) verticalSpace(10),
        ],
        verticalSpace(24),
        Align(
          alignment: Alignment.centerRight,
          child: _SkeletonBox(width: 135.w, height: 20.h),
        ),
        verticalSpace(12),
        _buildActionCard(),
        verticalSpace(10),
        _buildActionCard(),
        verticalSpace(120),
      ],
    );
  }

  Widget _buildStudentCard() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(28.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: _SkeletonBox(
                width: 88.w,
                height: 88.w,
                borderRadius: BorderRadius.circular(88.w),
              ),
            ),
            verticalSpace(18),
            FractionallySizedBox(
              widthFactor: 0.70,
              alignment: Alignment.centerRight,
              child: _SkeletonBox(height: 22.h),
            ),
            verticalSpace(10),
            FractionallySizedBox(
              widthFactor: 0.45,
              alignment: Alignment.centerRight,
              child: _SkeletonBox(height: 14.h),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            _SkeletonBox(
              width: 42.r,
              height: 42.r,
              borderRadius: BorderRadius.circular(12.r),
            ),
            horizontalSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FractionallySizedBox(
                    widthFactor: 0.55,
                    alignment: Alignment.centerRight,
                    child: _SkeletonBox(height: 14.h),
                  ),
                  verticalSpace(9),
                  FractionallySizedBox(
                    widthFactor: 0.85,
                    alignment: Alignment.centerRight,
                    child: _SkeletonBox(height: 10.h),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  const _SkeletonBox({required this.height, this.width, this.borderRadius});

  final double? width;
  final double height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0xFFE0E0E0),
          borderRadius: borderRadius ?? BorderRadius.circular(6.r),
        ),
      ),
    );
  }
}
