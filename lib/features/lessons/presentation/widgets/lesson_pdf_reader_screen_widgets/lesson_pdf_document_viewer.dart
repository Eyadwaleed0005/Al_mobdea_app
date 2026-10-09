import 'dart:typed_data';

import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class LessonPdfDocumentViewer extends StatelessWidget {
  const LessonPdfDocumentViewer({super.key, required this.pdfBytes});

  final Uint8List pdfBytes;

  @override
  Widget build(BuildContext context) {
    final overlayTextStyle = AppTextStyle.font12TextSecondaryRegularTajawal()
        .copyWith(color: Colors.white);
    return SfPdfViewerTheme(
      data: SfPdfViewerThemeData(
        backgroundColor: Colors.transparent,
        progressBarColor: ColorPalette.primary,
        scrollHeadStyle: PdfScrollHeadStyle(
          backgroundColor: ColorPalette.primary,
          pageNumberTextStyle: overlayTextStyle,
        ),
        scrollStatusStyle: PdfScrollStatusStyle(
          backgroundColor: ColorPalette.primary,
          pageInfoTextStyle: overlayTextStyle,
        ),
      ),
      child: SfPdfViewer.memory(
        pdfBytes,
        enableDoubleTapZooming: true,
        canShowScrollHead: true,
        canShowScrollStatus: true,
        canShowPaginationDialog: true,
      ),
    );
  }
}
