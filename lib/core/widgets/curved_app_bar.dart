import 'package:al_mobdea/app/routes/app_images_routes.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CurvedAppBar extends StatelessWidget {
  const CurvedAppBar({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: CustomPaint(
        painter: _CurvedHeaderPainter(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Row(
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                padding: EdgeInsets.only(top: 20.h, left: 20.w),
                constraints: BoxConstraints(),
                onPressed: () => Navigator.of(context).pop(),
                icon: SvgPicture.asset(AppImage().arrowBack, height: 10.h, width: 10.w),
              ),
              Flexible(
                child: Text(
                  title,
                  textDirection: TextDirection.rtl,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.font20TextPrimarySemiBoldKufam(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CurvedHeaderPainter extends CustomPainter {
  const _CurvedHeaderPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final baseline = size.height * 1;
    final path = Path()
      ..moveTo(0, baseline)
      ..cubicTo(
        size.width * 0.15,
        -size.height * 0.0000000000000001,
        size.width * 0.22,
        -size.height * 0.000000000000001,
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
