import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LiveSessionBadgeHeader extends StatefulWidget {
  const LiveSessionBadgeHeader({super.key});

  @override
  State<LiveSessionBadgeHeader> createState() => _LiveSessionBadgeHeaderState();
}

class _LiveSessionBadgeHeaderState extends State<LiveSessionBadgeHeader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    )..repeat(reverse: true);
    _pulse = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: ColorPalette.error.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        textDirection: TextDirection.rtl,
        children: [
          AnimatedBuilder(
            animation: _pulse,
            builder: (context, child) {
              final value = _pulse.value;
              return Transform.scale(
                scale: 0.82 + (value * 0.18),
                child: Container(
                  width: 9.r,
                  height: 9.r,
                  decoration: BoxDecoration(
                    color: ColorPalette.error,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: ColorPalette.error.withValues(
                          alpha: 0.15 + (value * 0.25),
                        ),
                        blurRadius: 3 + (value * 5),
                        spreadRadius: value,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          horizontalSpace(7),
          Text(
            'LIVE',
            textDirection: TextDirection.ltr,
            style: AppTextStyle.font12Wine600BoldTajawal().copyWith(
              color: ColorPalette.error,
            ),
          ),
        ],
      ),
    );
  }
}
