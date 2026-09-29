import 'package:al_mobdea/app/routes/app_images_routes.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/background/background_student_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LiveSessionAppBar extends StatelessWidget {
  const LiveSessionAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90.h,
      child: Stack(
        children: [
          const Positioned.fill(
            child: IgnorePointer(child: CustomPaint(painter: _CurvedHeaderPainter())),
          ),
          const Positioned.fill(
            child: IgnorePointer(child: StudentBackgroundCornerGradients(showBottomLeft: false)),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 60.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w),
                child: Row(
                  textDirection: TextDirection.rtl,
                  children: [
                    Expanded(
                      child: Text(
                        'البث المباشر',
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: AppTextStyle.font20TextPrimarySemiBoldKufam().copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 75.w,
                      child: IconButton(
                        tooltip: 'رجوع',
                        padding: EdgeInsets.zero,
                        onPressed: () => Navigator.of(context).pop(),
                        icon: SvgPicture.asset(AppImage().arrowBack, width: 12.w, height: 12.h),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CurvedHeaderPainter extends CustomPainter {
  const _CurvedHeaderPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final baseline = size.height * 0.98;
    final path = Path()
      ..moveTo(0, baseline)
      ..cubicTo(
        size.width * 0.15,
        -size.height * 0.000000009,
        size.width * 0.22,
        -size.height * 0.000000009,
        size.width * 0.37,
        baseline,
      )
      ..lineTo(size.width, baseline)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawShadow(path, ColorPalette.cardShadow.withValues(alpha: 0.19), 5, false);
    canvas.drawPath(path, Paint()..color = ColorPalette.cream50);
  }

  @override
  bool shouldRepaint(covariant _CurvedHeaderPainter oldDelegate) => false;
}
