import 'package:al_mobdea/app/routes/app_images_routes.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CurvedAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CurvedAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.showBackButton = true,
  });

  final String title;
  final VoidCallback? onBack;
  final bool showBackButton;

  static const double _curveEndFraction = 0.37;

  @override
  Size get preferredSize => Size.fromHeight(80.h);

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();
    final shouldShowBack = showBackButton && canPop;

    return SizedBox(
      height: preferredSize.height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final curveWidth =
              constraints.maxWidth * _curveEndFraction;

          return CustomPaint(
            painter: const _CurvedHeaderPainter(),
            child: Stack(
              children: [
                if (shouldShowBack)
                  Positioned(
                    left: 0,
                    top: 20.h,
                    bottom: 0,
                    width: curveWidth,
                    child: Center(
                      child: IconButton(
                        onPressed:
                            onBack ?? () => Navigator.of(context).pop(),
                        icon: SvgPicture.asset(
                          AppImage().arrowBack,
                          height: 10.h,
                          width: 10.w,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  left: curveWidth + 4.w,
                  right: 12.w,
                  top: 0,
                  bottom: 0,
                  child: ClipRect(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerRight,
                        child: Text(
                          title,
                          textDirection: TextDirection.rtl,
                          maxLines: 1,
                          softWrap: false,
                          style:
                              AppTextStyle.font20TextPrimarySemiBoldKufam(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CurvedHeaderPainter extends CustomPainter {
  const _CurvedHeaderPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final baseline = size.height;

    final path = Path()
      ..moveTo(0, baseline)
      ..cubicTo(
        size.width * 0.15,
        0,
        size.width * 0.22,
        0,
        size.width * CurvedAppBar._curveEndFraction,
        baseline,
      )
      ..lineTo(size.width, baseline)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawShadow(
      path,
      ColorPalette.cardShadow.withValues(alpha: 0.19),
      5,
      false,
    );

    canvas.drawPath(
      path,
      Paint()..color = ColorPalette.cream50,
    );
  }

  @override
  bool shouldRepaint(covariant _CurvedHeaderPainter oldDelegate) => false;
}