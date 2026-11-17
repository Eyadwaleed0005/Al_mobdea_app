import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class MySubscriptionLoadingSkeleton extends StatelessWidget {
  const MySubscriptionLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE0E0E0),
      highlightColor: const Color(0xFFF5F5F5),
      direction: ShimmerDirection.rtl,
      period: const Duration(milliseconds: 1300),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildStatusCard(),
          verticalSpace(20),
          _buildDetailsCard(),
          verticalSpace(28),
          Align(
            alignment: Alignment.centerRight,
            child: _buildBox(width: 130.w, height: 18.h),
          ),
          verticalSpace(14),
          _buildSupportCard(),
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    return _buildCard(
      radius: 24.r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              _buildBox(width: 48.r, height: 48.r, radius: 14.r),
              horizontalSpace(12),
              Expanded(
                child: FractionallySizedBox(
                  widthFactor: 0.80,
                  alignment: Alignment.centerRight,
                  child: _buildBox(height: 16.h),
                ),
              ),
            ],
          ),
          verticalSpace(26),
          Align(
            alignment: Alignment.centerRight,
            child: _buildBox(width: 110.w, height: 28.h, radius: 30.r),
          ),
          verticalSpace(16),
          _buildBox(height: 22.h),
          verticalSpace(14),
          _buildBox(height: 12.h),
          verticalSpace(8),
          FractionallySizedBox(
            widthFactor: 0.75,
            alignment: Alignment.centerRight,
            child: _buildBox(height: 12.h),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard() {
    return _buildCard(
      radius: 22.r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: _buildBox(width: 130.w, height: 18.h),
          ),
          verticalSpace(24),
          _buildDateRow(),
          verticalSpace(26),
          _buildDateRow(),
        ],
      ),
    );
  }

  Widget _buildDateRow() {
    return Row(
      textDirection: TextDirection.rtl,
      children: [
        _buildBox(width: 24.r, height: 24.r),
        horizontalSpace(12),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: _buildBox(width: 90.w, height: 12.h),
          ),
        ),
        horizontalSpace(12),
        _buildBox(width: 80.w, height: 14.h),
      ],
    );
  }

  Widget _buildSupportCard() {
    return _buildCard(
      radius: 18.r,
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          _buildBox(width: 28.r, height: 28.r),
          horizontalSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FractionallySizedBox(
                  widthFactor: 0.55,
                  alignment: Alignment.centerRight,
                  child: _buildBox(height: 14.h),
                ),
                verticalSpace(10),
                _buildBox(height: 10.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required Widget child, required double radius}) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: Colors.white),
      ),
      child: Padding(padding: EdgeInsets.all(20.r), child: child),
    );
  }

  Widget _buildBox({required double height, double? width, double? radius}) {
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
