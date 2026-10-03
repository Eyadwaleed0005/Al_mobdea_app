import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LessonPdfReaderHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const LessonPdfReaderHeader({
    super.key,
    required this.lessonTitle,
    this.isLandscape = false,
  });

  final String lessonTitle;
  final bool isLandscape;

  @override
  Size get preferredSize => Size.fromHeight(isLandscape ? 48.h : 58.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: isLandscape ? 48.h : 58.h,
      backgroundColor: ColorPalette.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        tooltip: 'رجوع',
        onPressed: () => Navigator.of(context).maybePop(),
        icon: const Icon(Icons.arrow_back_rounded),
      ),
      titleSpacing: 0,
      title: Text(
        lessonTitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textDirection: TextDirection.rtl,
        style: AppTextStyle.font15TextLightSemiBoldKufam().copyWith(
          fontSize: (isLandscape ? 13 : 15).sp,
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsetsDirectional.only(end: (isLandscape ? 10 : 16).w),
          child: Icon(
            Icons.picture_as_pdf_outlined,
            size: (isLandscape ? 20 : 24).sp,
          ),
        ),
      ],
    );
  }
}
