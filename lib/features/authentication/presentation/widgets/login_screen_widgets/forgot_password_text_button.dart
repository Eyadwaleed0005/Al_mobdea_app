import 'package:al_mobdea/core/constants/const.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/app_toast.dart';
import 'package:al_mobdea/core/widgets/custom_secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ForgotPasswordTextButton extends StatefulWidget {
  const ForgotPasswordTextButton({super.key, this.isLoading = false});

  final bool isLoading;

  @override
  State<ForgotPasswordTextButton> createState() => _ForgotPasswordButtonState();
}

class _ForgotPasswordButtonState extends State<ForgotPasswordTextButton> {
  bool _isOpening = false;

  Future<void> _openWhatsApp() async {
    if (widget.isLoading || _isOpening) {
      return;
    }

    setState(() => _isOpening = true);

    final uri = Uri.https('wa.me', '/${Const.teacherWhatsAppNumber}', {
      'text': Const.forgotPasswordMessage,
    });

    try {
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);

      if (!opened) {
        _showError();
      }
    } catch (_) {
      _showError();
    } finally {
      if (mounted) {
        setState(() => _isOpening = false);
      }
    }
  }

  void _showError() {
    if (!mounted) {
      return;
    }

    showAppToast(
      context,
      message: 'تعذّر فتح رابط واتساب، حاول مرة أخرى.',
      icon: Icons.error_outline_rounded,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomSecondaryButton(
      onPressed: widget.isLoading || _isOpening ? null : _openWhatsApp,
      hasBorder: false,
      text: 'نسيت كلمة المرور؟ تواصل مع المدرس.',
      textStyle: AppTextStyle.font13Wine200RegularTajawal(),
    );
  }
}
