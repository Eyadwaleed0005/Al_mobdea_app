import 'package:al_mobdea/app/routes/screen_routes/route_names.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/custom_operation_result_dialog.dart';
import 'package:al_mobdea/features/authentication/presentation/cubit/logout_cubit/logout_cubit.dart';
import 'package:al_mobdea/features/authentication/presentation/cubit/logout_cubit/logout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  static Future<void> show(BuildContext context) async {
    final cubit = context.read<LogoutCubit>();

    if (cubit.state is LogoutLoading) {
      return;
    }

    final navigator = Navigator.of(context, rootNavigator: true);

    final loggedOut = await showDialog<bool>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (_) {
        return BlocProvider.value(value: cubit, child: const LogoutDialog());
      },
    );

    if (loggedOut != true || !navigator.mounted) {
      return;
    }

    navigator.pushNamedAndRemoveUntil(RouteNames.loginScreen, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogoutCubit, LogoutState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.of(context).pop(true);
        }
      },
      builder: (context, state) {
        final isLoading = state is LogoutLoading;

        return PopScope<bool>(
          canPop: !isLoading,
          child: AbsorbPointer(
            absorbing: isLoading,
            child: CustomOperationResultDialog(
              type: CustomOperationResultType.failure,
              failureIcon: Icons.logout_outlined,
              title: 'تسجيل الخروج',
              message:
                  'هل أنت متأكد من تسجيل الخروج؟\n'
                  'ستبقى بياناتك محفوظة في حسابك.',
              actionText: 'تسجيل الخروج',
              secondaryActionText: 'إلغاء',
              isLoading: isLoading,
              content: state is LogoutFailure
                  ? Text(
                      state.error.message,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.font12ErrorRegularTajawal(),
                    )
                  : null,
              onActionPressed: () {
                final cubit = context.read<LogoutCubit>();

                if (cubit.state is LogoutLoading) {
                  return;
                }

                cubit.logout();
              },
              onSecondaryActionPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ),
        );
      },
    );
  }
}
