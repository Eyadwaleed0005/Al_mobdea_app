import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/features/profile/presentation/widgets/profile_screen_widgets/profile_action_card.dart';
import 'package:flutter/material.dart';

class ProfileActionsList extends StatelessWidget {
  const ProfileActionsList({
    super.key,
    this.onPersonalInfo,
    this.onSubscription,
    this.onAboutTeacher,
    this.onSupport,
    this.onDeleteAccount,
    this.onLogout,
  });

  final VoidCallback? onPersonalInfo;
  final VoidCallback? onSubscription;
  final VoidCallback? onAboutTeacher;
  final VoidCallback? onSupport;
  final VoidCallback? onDeleteAccount;
  final VoidCallback? onLogout;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildSectionTitle('حسابي'),
        verticalSpace(12),
        ProfileActionCard(
          icon: Icons.person_outline_rounded,
          title: 'البيانات الشخصية',
          subtitle: 'الاسم ورقم الهاتف والبريد الإلكتروني',
          onTap: onPersonalInfo,
        ),
        verticalSpace(10),
        ProfileActionCard(
          icon: Icons.card_membership_outlined,
          title: 'اشتراكي',
          subtitle: 'حالة اشتراكك وتفاصيله',
          onTap: onSubscription,
        ),
        verticalSpace(10),
        ProfileActionCard(
          icon: Icons.delete_outline_rounded,
          title: 'حذف الحساب',
          subtitle: 'حذف حسابك والبيانات المرتبطة به',
          onTap: onDeleteAccount,
          isDestructive: true,
        ),
        verticalSpace(10),
        ProfileActionCard(
          icon: Icons.logout_outlined,
          title: 'تسجيل الخروج',
          subtitle: 'تبقى بياناتك محفوظة في حسابك',
          onTap: onLogout,
          showArrow: false,
        ),
        verticalSpace(24),
        _buildSectionTitle('الدعم والمعلومات'),
        verticalSpace(12),
        ProfileActionCard(
          icon: Icons.person_pin_outlined,
          title: 'عن المعلّم',
          subtitle: 'تعرّف على معلّمك وطرق التواصل',
          onTap: onAboutTeacher,
        ),
        verticalSpace(10),
        ProfileActionCard(
          icon: Icons.support_agent_rounded,
          title: 'تواصل مع الدعم',
          subtitle: 'مساعدة بخصوص حسابك',
          onTap: onSupport,
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.right,
      style: AppTextStyle.font16TextPrimarySemiBoldKufam().copyWith(
        color: ColorPalette.primary,
      ),
    );
  }
}
