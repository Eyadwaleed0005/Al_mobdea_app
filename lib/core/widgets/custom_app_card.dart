import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:al_mobdea/core/style/app_color.dart';

class CustomAppCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final Color? color;
  final List<BoxShadow>? boxShadow;

  final double? backdropBlur;

  const CustomAppCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.color,
    this.boxShadow,
    this.backdropBlur,
  });

  static const double _fillOpacity = 0.84;

  static const double _defaultBackdropBlur = 22;

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = BorderRadius.circular((borderRadius ?? 32).r);

    final Color cardColor = color ?? ColorPalette.cardFill.withValues(alpha: _fillOpacity);

    final List<BoxShadow> shadows =
        boxShadow ??
        [
          BoxShadow(
            color: ColorPalette.cardShadow.withValues(alpha: 0.14),
            offset: const Offset(0, 14),
            blurRadius: 35,
            spreadRadius: -4,
          ),
        ];

    Widget content = Container(
      width: width,
      height: height,
      padding: padding ?? EdgeInsets.symmetric(horizontal: 20.w, vertical: 28.h),
      color: cardColor,
      child: child,
    );

    final double blur = backdropBlur ?? _defaultBackdropBlur;

    if (blur > 0) {
      content = BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur / 2, sigmaY: blur / 2),
        child: content,
      );
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(borderRadius: radius, boxShadow: shadows),
      child: ClipRRect(borderRadius: radius, child: content),
    );
  }
}
