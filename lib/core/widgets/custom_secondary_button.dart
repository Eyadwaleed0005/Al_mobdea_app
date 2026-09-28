import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/app_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSecondaryButton extends StatelessWidget {
  const CustomSecondaryButton({
    super.key,
    this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.height,
    this.icon,
    this.child,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.foregroundColor,
    this.textStyle,
    this.padding,
    this.hasBorder = true,
  });

  final String? text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final IconData? icon;
  final Widget? child;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final Color? foregroundColor;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final bool hasBorder;

  @override
  Widget build(BuildContext context) {
    final Color resolvedBackgroundColor =
        backgroundColor ?? (hasBorder ? ColorPalette.surface : Colors.transparent);

    final Color resolvedForegroundColor =
        foregroundColor ?? (hasBorder ? ColorPalette.primary : ColorPalette.wine200);

    final Color resolvedBorderColor =
        borderColor ?? (hasBorder ? ColorPalette.softSage : Colors.transparent);

    final bool showBorder =
        hasBorder && resolvedBorderColor != Colors.transparent && (borderWidth ?? 1) > 0;

    final Widget content = isLoading
        ? AppLoadingIndicator(
            color: resolvedForegroundColor,
            size: 22,
            strokeWidth: 2.5,
            wavelength: 12,
            waveSpeed: 10,
          )
        : child ??
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 18.sp, color: resolvedForegroundColor),
                    SizedBox(width: 4.w),
                  ],
                  Flexible(
                    child: Text(
                      text ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style:
                          (textStyle ??
                                  (hasBorder
                                      ? AppTextStyle.font13TextLightSemiBoldTajawal()
                                      : AppTextStyle.font13Wine200RegularTajawal()))
                              .copyWith(
                                color:
                                    foregroundColor ?? textStyle?.color ?? resolvedForegroundColor,
                              ),
                    ),
                  ),
                ],
              );

    final ButtonStyle buttonStyle = OutlinedButton.styleFrom(
      tapTargetSize: hasBorder ? MaterialTapTargetSize.padded : MaterialTapTargetSize.shrinkWrap,
      minimumSize: hasBorder ? Size(width ?? double.infinity, height ?? 52.h) : Size.zero,
      padding:
          padding ??
          (hasBorder
              ? EdgeInsets.symmetric(horizontal: 8.w)
              : EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w)),
      backgroundColor: resolvedBackgroundColor,
      disabledBackgroundColor: resolvedBackgroundColor,
      foregroundColor: resolvedForegroundColor,
      disabledForegroundColor: resolvedForegroundColor,
      side: showBorder
          ? BorderSide(color: resolvedBorderColor, width: (borderWidth ?? 1.5).w)
          : BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular((borderRadius ?? (hasBorder ? 12 : 8)).r),
      ),
      elevation: 0,
    );

    final Widget button = OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: buttonStyle,
      child: content,
    );

    if (hasBorder) {
      return SizedBox(width: width ?? double.infinity, height: height ?? 52.h, child: button);
    }

    if (width != null || height != null) {
      return SizedBox(width: width, height: height, child: button);
    }

    return button;
  }
}
