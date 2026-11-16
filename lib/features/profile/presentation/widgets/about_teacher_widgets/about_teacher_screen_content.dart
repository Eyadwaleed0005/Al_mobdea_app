import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/custom_app_bar.dart';
import 'package:al_mobdea/features/profile/presentation/widgets/about_teacher_widgets/teacher_social_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutTeacherScreenContent extends StatelessWidget {
  const AboutTeacherScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          verticalSpace(12),
          const CustomAppBar(
            title: 'عن المعلّم',
            backgroundColor: Colors.transparent,
            showBackButton: true,
          ),
          verticalSpace(24),
          _buildTeacherCard(),
          verticalSpace(28),
          _buildIntroduction(),
          verticalSpace(30),
          const TeacherSocialLinks(),
          SizedBox(height: 40.h + MediaQuery.viewPaddingOf(context).bottom),
        ],
      ),
    );
  }

  Widget _buildTeacherCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [ColorPalette.wine500, ColorPalette.wine700],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 24.h, left: 20.w, right: 20.w),
              child: Image.asset(
                'assets/images/teacher_portrait.png',
                height: 300.h,
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
          ColoredBox(
            color: ColorPalette.cream100,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 22.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'المبدع في اللغة العربية',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.font20TextPrimarySemiBoldKufam()
                        .copyWith(color: ColorPalette.primary, height: 1.6),
                  ),
                  verticalSpace(8),
                  Text(
                    'معلّم اللغة العربية',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: AppTextStyle.font14TextSecondaryRegularTajawal(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroduction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'عن منصة المبدع',
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          style: AppTextStyle.font18TextPrimarySemiBoldKufam(),
        ),
        verticalSpace(12),
        Text(
          'منصة تعليمية للغة العربية، تجمع الدروس والمذكرات '
          'والاختبارات في مكان واحد، لتقدر تتابع المحتوى '
          'الخاص بصفّك الدراسي وتراجع نتائجك بسهولة.',
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          style: AppTextStyle.font14TextSecondaryRegularTajawal().copyWith(
            height: 1.9,
          ),
        ),
      ],
    );
  }
}
