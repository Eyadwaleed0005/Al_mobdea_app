import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/app_loading_indicator.dart';
import 'package:flutter/material.dart';

class StudyNotePdfLoadingView extends StatelessWidget {
  const StudyNotePdfLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppLoadingIndicator(color: ColorPalette.primary),
          verticalSpace(16),
          Text(
            'جارٍ تحميل المذكرة',
            textDirection: TextDirection.rtl,
            style: AppTextStyle.font17TextPrimarySemiBoldKufam(),
          ),
          verticalSpace(8),
          Text(
            'ستكون متاحة للقراءة دون اتصال بعد تنزيلها.',
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: AppTextStyle.font14TextSecondaryRegularTajawal(),
          ),
        ],
      ),
    );
  }
}
