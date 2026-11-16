import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LessonsLoadingSkeleton extends StatelessWidget {
  const LessonsLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: 112.h),
      itemCount: 3,
      separatorBuilder: (_, __) => verticalSpace(22),
      itemBuilder: (_, __) => _buildCard(),
    );
  }

  Widget _buildCard() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22.r),
        child: Shimmer.fromColors(
          baseColor: const Color(0xFFE0E0E0),
          highlightColor: const Color(0xFFF5F5F5),
          direction: ShimmerDirection.rtl,
          period: const Duration(milliseconds: 1300),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AspectRatio(
                aspectRatio: 16 / 9,
                child: ColoredBox(color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildBox(height: 18.h),
                    verticalSpace(10),
                    FractionallySizedBox(
                      alignment: Alignment.centerRight,
                      widthFactor: 0.65,
                      child: _buildBox(height: 14.h),
                    ),
                    verticalSpace(10),
                    FractionallySizedBox(
                      alignment: Alignment.centerRight,
                      widthFactor: 0.85,
                      child: _buildBox(height: 12.h),
                    ),
                    verticalSpace(16),
                    _buildBox(height: 38.h, radius: 10.r),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBox({required double height, double? radius}) {
    return SizedBox(
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
