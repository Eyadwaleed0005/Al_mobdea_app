import 'package:al_mobdea/app/dependency_injection/service_locator.dart';
import 'package:al_mobdea/app/routes/screen_routes/route_names.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/custom_operation_result_dialog.dart';
import 'package:al_mobdea/core/widgets/custom_text_form_field.dart';
import 'package:al_mobdea/features/profile/presentation/cubit/delete_account_cubit/delete_account_cubit.dart';
import 'package:al_mobdea/features/profile/presentation/cubit/delete_account_cubit/delete_account_state.dart';
import 'package:al_mobdea/features/profile/presentation/validation/update_profile_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({super.key});

  static Future<void> show(BuildContext context) async {
    final navigator = Navigator.of(context, rootNavigator: true);

    final deleted = await showDialog<bool>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (_) {
        return BlocProvider<DeleteAccountCubit>(
          create: (_) => getIt<DeleteAccountCubit>(),
          child: const DeleteAccountDialog(),
        );
      },
    );

    if (deleted != true || !navigator.mounted) {
      return;
    }

    navigator.pushNamedAndRemoveUntil(RouteNames.loginScreen, (route) => false);
  }

  @override
  State<DeleteAccountDialog> createState() {
    return _DeleteAccountDialogState();
  }
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();

  void _deleteAccount() {
    final cubit = context.read<DeleteAccountCubit>();

    if (cubit.state is DeleteAccountLoading) {
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    cubit.deleteAccount(currentPassword: _passwordController.text);
  }

  @override
  void dispose() {
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteAccountCubit, DeleteAccountState>(
      listener: (context, state) {
        if (state is DeleteAccountSuccess) {
          _passwordController.clear();
          Navigator.of(context).pop(true);
        }
      },
      builder: (context, state) {
        final isLoading = state is DeleteAccountLoading;

        return PopScope<bool>(
          canPop: !isLoading,
          child: AbsorbPointer(
            absorbing: isLoading,
            child: CustomOperationResultDialog(
              type: CustomOperationResultType.failure,
              failureIcon: Icons.delete_forever_outlined,
              title: 'حذف الحساب نهائيًا',
              message:
                  'سيتم حذف حسابك وبياناته المرتبطة على منصة المبدع، '
                  'بما فيها بيانات الاشتراك ونتائج الامتحانات.\n\n'
                  'لا يمكن التراجع عن الحذف أو استعادة البيانات. '
                  'أدخل كلمة المرور الحالية لتأكيد الحذف.',
              actionText: 'حذف الحساب',
              secondaryActionText: 'إلغاء',
              isLoading: isLoading,
              content: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFormField(
                      controller: _passwordController,
                      labelText: 'كلمة المرور الحالية',
                      hintText: 'أدخل كلمة المرور',
                      enabled: !isLoading,
                      isPassword: true,
                      showPasswordCopyIcon: false,
                      textDirection: TextDirection.ltr,
                      textInputAction: TextInputAction.done,
                      autovalidateMode: AutovalidateMode.disabled,
                      validator: UpdateProfileValidator.currentPassword,
                      onChanged: (_) {
                        context.read<DeleteAccountCubit>().clearError();
                      },
                    ),
                    if (state is DeleteAccountFailure) ...[
                      verticalSpace(12),
                      Text(
                        state.error.message,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: AppTextStyle.font12ErrorRegularTajawal(),
                      ),
                    ],
                  ],
                ),
              ),
              onActionPressed: _deleteAccount,
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
