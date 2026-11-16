import 'package:al_mobdea/app/routes/screen_routes/route_names.dart';
import 'package:al_mobdea/core/constants/const.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_animations.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/app_toast.dart';
import 'package:al_mobdea/features/authentication/presentation/cubit/logout_cubit/logout_cubit.dart';
import 'package:al_mobdea/features/authentication/presentation/cubit/logout_cubit/logout_state.dart';
import 'package:al_mobdea/features/profile/domain/entities/profile_entity.dart';
import 'package:al_mobdea/features/profile/presentation/widgets/profile_screen_widgets/delete_account_dialog.dart';
import 'package:al_mobdea/features/profile/presentation/widgets/profile_screen_widgets/logout_dialog.dart';
import 'package:al_mobdea/features/profile/presentation/widgets/profile_screen_widgets/profile_actions_list.dart';
import 'package:al_mobdea/features/profile/presentation/widgets/profile_screen_widgets/profile_student_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileSuccessView extends StatefulWidget {
  const ProfileSuccessView({
    super.key,
    required this.profile,
    this.onPersonalInfo,
    this.onSubscription,
    this.onAboutTeacher,
    this.onSupport,
    this.onDeleteAccount,
    this.onLogout,
  });

  final ProfileEntity profile;

  final VoidCallback? onPersonalInfo;
  final VoidCallback? onSubscription;
  final VoidCallback? onAboutTeacher;
  final VoidCallback? onSupport;
  final VoidCallback? onDeleteAccount;
  final VoidCallback? onLogout;

  @override
  State<ProfileSuccessView> createState() {
    return _ProfileSuccessViewState();
  }
}

class _ProfileSuccessViewState extends State<ProfileSuccessView> {
  bool _isAccountDialogOpen = false;
  bool _isOpeningSupport = false;

  bool get _isBusy => _isAccountDialogOpen || _isOpeningSupport;

  bool get _isLoggingOut {
    return context.read<LogoutCubit>().state is LogoutLoading;
  }

  Future<void> _contactSupport() async {
    if (_isBusy || _isLoggingOut) {
      return;
    }

    setState(() {
      _isOpeningSupport = true;
    });

    try {
      final uri = Uri.https('wa.me', '/${Const.teacherWhatsAppNumber}');

      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);

      if (!opened && mounted) {
        _showSupportError();
      }
    } catch (_) {
      if (mounted) {
        _showSupportError();
      }
    } finally {
      if (mounted) {
        setState(() {
          _isOpeningSupport = false;
        });
      }
    }
  }

  void _showSupportError() {
    showAppToast(
      context,
      message: 'تعذر فتح واتساب. حاول مرة أخرى.',
      icon: Icons.error_outline_rounded,
    );
  }

  Future<void> _showDeleteAccountDialog() async {
    if (_isBusy || _isLoggingOut) {
      return;
    }

    setState(() {
      _isAccountDialogOpen = true;
    });

    try {
      await DeleteAccountDialog.show(context);
    } finally {
      if (mounted) {
        setState(() {
          _isAccountDialogOpen = false;
        });
      }
    }
  }

  Future<void> _showLogoutDialog() async {
    if (_isBusy || _isLoggingOut) {
      return;
    }

    setState(() {
      _isAccountDialogOpen = true;
    });

    try {
      await LogoutDialog.show(context);
    } finally {
      if (mounted) {
        setState(() {
          _isAccountDialogOpen = false;
        });
      }
    }
  }

  void _openPersonalInfo() {
    Navigator.of(context).pushNamed(RouteNames.personalInfoScreen);
  }

  void _openSubscription() {
    Navigator.of(context).pushNamed(RouteNames.mySubscriptionScreen);
  }

  void _openAboutTeacher() {
    Navigator.of(context).pushNamed(RouteNames.aboutTeacherScreen);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          verticalSpace(12),
          AppAnimations.screenSection(
            delay: 100,
            child: Text(
              'حسابي',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              style: AppTextStyle.font24TextPrimarySemiBoldKufam(),
            ),
          ),
          verticalSpace(20),
          AppAnimations.screenSection(
            delay: 250,
            child: ProfileStudentCard(profile: widget.profile),
          ),
          verticalSpace(28),
          AppAnimations.screenSection(
            delay: 450,
            child: BlocSelector<LogoutCubit, LogoutState, bool>(
              selector: (state) => state is LogoutLoading,
              builder: (context, isLoggingOut) {
                return AbsorbPointer(
                  absorbing: _isBusy || isLoggingOut,
                  child: ProfileActionsList(
                    onPersonalInfo: widget.onPersonalInfo ?? _openPersonalInfo,
                    onSubscription: widget.onSubscription ?? _openSubscription,
                    onAboutTeacher: widget.onAboutTeacher ?? _openAboutTeacher,
                    onSupport: widget.onSupport ?? _contactSupport,
                    onDeleteAccount:
                        widget.onDeleteAccount ?? _showDeleteAccountDialog,
                    onLogout: widget.onLogout ?? _showLogoutDialog,
                  ),
                );
              },
            ),
          ),
          verticalSpace(120),
        ],
      ),
    );
  }
}
