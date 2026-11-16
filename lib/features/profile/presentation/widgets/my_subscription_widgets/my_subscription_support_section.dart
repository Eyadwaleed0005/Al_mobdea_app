import 'package:al_mobdea/app/dependency_injection/service_locator.dart';
import 'package:al_mobdea/core/constants/const.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/app_toast.dart';
import 'package:al_mobdea/features/profile/domain/use_cases/get_personal_info_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class MySubscriptionSupportSection extends StatefulWidget {
  const MySubscriptionSupportSection({super.key});

  @override
  State<MySubscriptionSupportSection> createState() {
    return _MySubscriptionSupportSectionState();
  }
}

class _MySubscriptionSupportSectionState
    extends State<MySubscriptionSupportSection> {
  bool _isOpening = false;

  Future<void> _contactSupport() async {
    if (_isOpening) {
      return;
    }

    _isOpening = true;

    try {
      final result = await getIt<GetPersonalInfoUseCase>()();

      if (!mounted) {
        return;
      }

      await result.fold<Future<void>>(
        (error) async {
          showAppToast(
            context,
            message: error.message,
            icon: Icons.error_outline_rounded,
          );
        },
        (personalInfo) async {
          final message = [
            'السلام عليكم،',
            'عندي استفسار بخصوص حالة اشتراكي على منصة المبدع.',
            '',
            'بيانات الطالب:',
            'الاسم: ${personalInfo.name.trim()}',
            'رقم الهاتف: ${personalInfo.phoneNumber.trim()}',
            'البريد الإلكتروني: ${personalInfo.email.trim()}',
          ].join('\n');

          final uri = Uri.https('wa.me', '/${Const.teacherWhatsAppNumber}', {
            'text': message,
          });

          final opened = await launchUrl(
            uri,
            mode: LaunchMode.externalApplication,
          );

          if (!opened && mounted) {
            _showContactError();
          }
        },
      );
    } catch (_) {
      if (mounted) {
        _showContactError();
      }
    } finally {
      _isOpening = false;
    }
  }

  void _showContactError() {
    showAppToast(
      context,
      message: 'تعذر فتح واتساب. حاول مرة أخرى.',
      icon: Icons.error_outline_rounded,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'عندك استفسار عن اشتراكك؟',
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: AppTextStyle.font16TextPrimarySemiBoldKufam(),
          ),
          verticalSpace(10),
          Text(
            'تواصل مع الدعم لمراجعة حالة اشتراكك وبياناته.',
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: AppTextStyle.font13TextSecondaryRegularTajawal().copyWith(
              height: 1.6,
            ),
          ),
          verticalSpace(18),
          Center(
            child: TextButton(
              onPressed: _contactSupport,
              style: TextButton.styleFrom(
                foregroundColor: ColorPalette.primary,
                backgroundColor: ColorPalette.wine50,
                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 13.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                textDirection: TextDirection.rtl,
                children: [
                  Icon(Icons.chat_bubble_outline_rounded, size: 19.sp),
                  horizontalSpace(8),
                  Text(
                    'تواصل مع الدعم',
                    textDirection: TextDirection.rtl,
                    style: AppTextStyle.font15PrimaryBoldTajawal(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
