import 'package:al_mobdea/app/routes/screen_routes/route_names.dart';
import 'package:al_mobdea/core/helper/app_system_ui.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_animations.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/custom_app_card.dart';
import 'package:al_mobdea/features/authentication/presentation/widgets/login_screen_widgets/login_background.dart';
import 'package:al_mobdea/features/authentication/presentation/widgets/login_screen_widgets/login_logo.dart';
import 'package:al_mobdea/features/authentication/presentation/widgets/register_screen_widgets/register_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreenContent extends StatelessWidget {
  const RegisterScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.dark(),
      child: LoginBackground(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              verticalSpace(40),
              const CustomLogInLogo(),
              verticalSpace(12),
              AppAnimations.primaryTitle(
                child: Text(
                  'المبدع',
                  style: AppTextStyle.font26PageTitleBoldKufam(),
                ),
              ),
              verticalSpace(6),
              AppAnimations.secondaryTitle(
                child: Text(
                  'منصة اللغة العربية',
                  style: AppTextStyle.font14TextSecondaryRegularTajawal()
                      .copyWith(
                        color: ColorPalette.cardShadow.withValues(alpha: .6),
                      ),
                ),
              ),
              verticalSpace(20),
              AppAnimations.screenSection(
                delay: 900,
                child: CustomAppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'إنشاء حساب جديد',
                        style: AppTextStyle.font20TextBlackSemiBoldKufam(),
                        textAlign: TextAlign.center,
                      ),
                      verticalSpace(8),
                      Text(
                        'أدخل بياناتك لإنشاء حسابك على منصة المبدع.',
                        style: AppTextStyle.font14TextSecondaryRegularTajawal(),
                        textAlign: TextAlign.center,
                      ),
                      verticalSpace(24),
                      RegisterForm(
                        onRegistered: () {
                          Navigator.of(
                            context,
                            rootNavigator: true,
                          ).pushNamedAndRemoveUntil(
                            RouteNames.mainNavigationScreen,
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpace(50),
            ],
          ),
        ),
      ),
    );
  }
}
