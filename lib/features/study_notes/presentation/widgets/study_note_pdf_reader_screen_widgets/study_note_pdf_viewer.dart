import 'dart:typed_data';

import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class StudyNotePdfViewer extends StatelessWidget {
  const StudyNotePdfViewer({super.key, required this.pdfBytes});

  final Uint8List pdfBytes;

  @override
  Widget build(BuildContext context) {
    final pageTextStyle = AppTextStyle.font12TextSecondaryMediumTajawal()
        .copyWith(color: ColorPalette.textLight);
    return SfPdfViewerTheme(
      data: SfPdfViewerThemeData(
        backgroundColor: ColorPalette.background.withValues(alpha: 0),
        progressBarColor: ColorPalette.primary,
        scrollHeadStyle: PdfScrollHeadStyle(
          backgroundColor: ColorPalette.primary,
          pageNumberTextStyle: pageTextStyle,
        ),
        scrollStatusStyle: PdfScrollStatusStyle(
          backgroundColor: ColorPalette.primary,
          pageInfoTextStyle: pageTextStyle,
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
