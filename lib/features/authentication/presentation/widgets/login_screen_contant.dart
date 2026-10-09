import 'package:al_mobdea/core/helper/app_system_ui.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_animations.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/custom_app_card.dart';
import 'package:al_mobdea/features/authentication/presentation/widgets/login_background.dart';
import 'package:al_mobdea/features/authentication/presentation/widgets/login_form.dart';
import 'package:al_mobdea/features/authentication/presentation/widgets/login_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreenContant extends StatelessWidget {
  const LoginScreenContant({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.dark(),
      child: LoginBackground(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            children: [
              verticalSpace(45),
              AppAnimations.logoEntrance(child: const CustomLogInLogo()),
              verticalSpace(20),
              AppAnimations.secondaryTitle(
                child: Text(
                  'معلم خبير لغة عربية',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.font14TextSecondaryRegularTajawal(),
                ),
              ),
              verticalSpace(22),
              AppAnimations.screenSection(
                delay: 600,
                child: CustomAppCard(
                  borderRadius: 34,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 28.h),
                  child: Column(
                    children: [
                      Text('أهلاً بك من جديد', style: AppTextStyle.font21TextDarkBoldKufam()),
                      verticalSpace(8),
                      Text(
                        'سجّل دخولك للوصول إلى دروسك واختباراتك',
                        style: AppTextStyle.font13TextSecondaryRegularTajawal(),
                        textAlign: TextAlign.center,
                      ),
                      verticalSpace(24),
                      const LoginForm(),
                    ],
                  ),
                ),
              ),
              verticalSpace(40),
            ],
          ),
        ),
      ),
    );
  }
}
