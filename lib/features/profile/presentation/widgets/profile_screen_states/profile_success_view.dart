import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/app_animations.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/app_loading_indicator.dart';
import 'package:al_mobdea/core/widgets/custom_dialog.dart';
import 'package:al_mobdea/features/authentication/presentation/cubit/logout_cubit/logout_cubit.dart';
import 'package:al_mobdea/features/authentication/presentation/cubit/logout_cubit/logout_state.dart';
import 'package:al_mobdea/features/profile/domain/entities/profile_entity.dart';
import 'package:al_mobdea/features/profile/presentation/widgets/profile_info_card.dart';
import 'package:al_mobdea/features/profile/presentation/widgets/profile_info_title.dart';
import 'package:al_mobdea/features/profile/presentation/widgets/profile_student_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileSuccessView extends StatelessWidget {
  const ProfileSuccessView({super.key, required this.profile});

  final ProfileEntity profile;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          verticalSpace(12),
          AppAnimations.screenSection(delay: 100, child: _buildHeader()),
          verticalSpace(20),
          AppAnimations.screenSection(delay: 250, child: ProfileStudentCard(profile: profile)),
          verticalSpace(28),
          AppAnimations.screenSection(delay: 450, child: ProfileInfoTitle(title: 'معلوماتي')),
          verticalSpace(12),
          AppAnimations.screenSection(delay: 550, child: ProfileInfoCard(profile: profile)),
          verticalSpace(24),
          AppAnimations.screenSection(
            delay: 650,
            child: BlocSelector<LogoutCubit, LogoutState, bool>(
              selector: (state) => state is LogoutLoading,
              builder: (context, isLoading) {
                return _LogoutButton(
                  isLoading: isLoading,
                  onPressed: () {
                    if (isLoading) return;
                    _showLogoutDialog(context);
                  },
                );
              },
            ),
          ),
          verticalSpace(120),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'حسابي',
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
          style: AppTextStyle.font24TextPrimarySemiBoldKufam(),
        ),
        verticalSpace(12),
        Text(
          'بياناتك واشتراكك في مكان واحد',
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          style: AppTextStyle.font15TextSecondaryRegularTajawal(),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    CustomDialog.showDelete(
      context,
      icon: Icons.logout_outlined,
      iconBorderRadius: BorderRadius.circular(16.r),
      title: 'هل أنت متأكد من أنك تريد تسجيل الخروج؟',
      message: 'ستحتاج إلى تسجيل الدخول مرة أخرى للوصول إلى حسابك.',
      primaryText: 'تسجيل الخروج',
      secondaryText: 'إلغاء',
      onDelete: () {
        context.read<LogoutCubit>().logout();
      },
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({required this.isLoading, required this.onPressed});

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorPalette.surface,
      borderRadius: BorderRadius.circular(20.r),
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          width: double.infinity,
          height: 54.h,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: ColorPalette.border, width: 1.w),
          ),
          alignment: Alignment.center,
          child: isLoading
              ? const AppLoadingIndicator(
                  color: ColorPalette.primary,
                  size: 22,
                  strokeWidth: 2.5,
                  wavelength: 12,
                  waveSpeed: 10,
                )
              : Text(
                  'تسجيل الخروج',
                  textDirection: TextDirection.rtl,
                  style: AppTextStyle.font15PrimaryBoldTajawal(),
                ),
        ),
      ),
    );
  }
}
