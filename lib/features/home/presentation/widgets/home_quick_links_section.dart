import 'package:al_mobdea/app/routes/app_images_routes.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/features/home/presentation/widgets/category_navigation_card.dart';
import 'package:flutter/material.dart';

class HomeQuickLinksSection extends StatelessWidget {
  const HomeQuickLinksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'وصول سريع',
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: AppTextStyle.font23TextDarkBoldKufam(),
        ),
        verticalSpace(29),
        Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: CategoryNavigationCard(
                  label: 'الدروس',
                  details: '12 درسًا',
                  image: AppImage().lessons,
                  onTap: () => {},
                ),
              ),
              horizontalSpace(8),
              Expanded(
                child: CategoryNavigationCard(
                  label: 'المذكرات',
                  details: 'ملفات PDF',
                  image: AppImage().studyNotes,
                  onTap: () => {},
                ),
              ),
              horizontalSpace(8),
              Expanded(
                child: CategoryNavigationCard(
                  label: 'الاختبارات',
                  details: 'جرّب نفسك',
                  image: AppImage().exam,
                  onTap: () => {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
