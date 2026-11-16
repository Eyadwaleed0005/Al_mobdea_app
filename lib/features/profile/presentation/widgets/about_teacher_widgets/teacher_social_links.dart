import 'package:al_mobdea/core/constants/const.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class TeacherSocialLinks extends StatefulWidget {
  const TeacherSocialLinks({super.key});

  @override
  State<TeacherSocialLinks> createState() {
    return _TeacherSocialLinksState();
  }
}

class _TeacherSocialLinksState extends State<TeacherSocialLinks> {
  bool _isOpening = false;

  Future<void> _openLink(String url) async {
    if (_isOpening) {
      return;
    }

    _isOpening = true;

    try {
      final opened = await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );

      if (!opened && mounted) {
        _showError();
      }
    } catch (_) {
      if (mounted) {
        _showError();
      }
    } finally {
      _isOpening = false;
    }
  }

  void _showError() {
    showAppToast(
      context,
      message: 'تعذر فتح الرابط. حاول مرة أخرى.',
      icon: Icons.error_outline_rounded,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'تابع المعلّم وتواصل معاه',
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          style: AppTextStyle.font16TextPrimarySemiBoldKufam(),
        ),
        verticalSpace(16),
        Material(
          color: ColorPalette.cardBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
            side: const BorderSide(color: ColorPalette.border),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              _buildLink(
                title: 'واتساب',
                subtitle: 'للتواصل والاستفسارات',
                icon: Icons.chat_outlined,
                url: Const.teacherWhatsAppUrl,
              ),
              _buildDivider(),
              _buildLink(
                title: 'فيسبوك',
                subtitle: 'تابع الأخبار والمنشورات',
                icon: Icons.facebook,
                url: Const.teacherFacebookUrl,
              ),
              _buildDivider(),
              _buildLink(
                title: 'إنستجرام',
                subtitle: 'تابع أحدث المشاركات',
                icon: Icons.camera_alt_outlined,
                url: Const.teacherInstagramUrl,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLink({
    required String title,
    required String subtitle,
    required IconData icon,
    required String url,
  }) {
    return InkWell(
      onTap: () {
        _openLink(url);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
        child: Row(
          textDirection: TextDirection.rtl,
          children: [
            Icon(icon, color: ColorPalette.primary, size: 26.sp),
            horizontalSpace(14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: AppTextStyle.font14TextPrimarySemiBoldKufam(),
                  ),
                  verticalSpace(5),
                  Text(
                    subtitle,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: AppTextStyle.font12TextSecondaryRegularTajawal(),
                  ),
                ],
              ),
            ),
            horizontalSpace(8),
            Icon(
              Icons.open_in_new_rounded,
              color: ColorPalette.primary,
              size: 18.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: const Divider(height: 1, color: ColorPalette.divider),
    );
  }
}
