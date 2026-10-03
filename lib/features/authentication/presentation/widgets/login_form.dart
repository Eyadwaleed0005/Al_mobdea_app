import 'package:al_mobdea/app/routes/screen_routes/route_names.dart';
import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/custom_button.dart';
import 'package:al_mobdea/core/widgets/custom_operation_result_dialog.dart';
import 'package:al_mobdea/core/widgets/custom_secondary_button.dart';
import 'package:al_mobdea/core/widgets/custom_text_form_field.dart';
import 'package:al_mobdea/features/authentication/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:al_mobdea/features/authentication/presentation/validation/login_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isObscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();

      context.read<LoginCubit>().login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  void _navigateToMainScreen(BuildContext context) {
    Navigator.of(
      context,
      rootNavigator: true,
    ).pushNamedAndRemoveUntil(RouteNames.mainNavigationScreen, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          showDialog<void>(
            context: context,
            builder: (dialogContext) {
              return CustomOperationResultDialog(
                type: CustomOperationResultType.failure,
                title: 'خطأ في تسجيل الدخول',
                message: state.errorMessage,
                actionText: 'حاول مرة أخرى',
              );
            },
          );
        } else if (state is LoginSuccess) {
          showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (dialogContext) {
              return CustomOperationResultDialog(
                type: CustomOperationResultType.success,
                title: 'تم تسجيل الدخول بنجاح',
                message: 'مرحباً بك مجدداً في منصة المبدع',
                actionText: 'متابعة',
                onActionPressed: () {
                  _navigateToMainScreen(context);
                },
              );
            },
          );
        }
      },
      builder: (context, state) {
        final bool isLoading = state is LoginLoading;

        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomTextFormField(
                labelText: 'البريد الإلكتروني',
                hintText: 'example@email.com',
                controller: _emailController,
                validator: LoginValidation.email,
                readOnly: isLoading,
                textDirection: TextDirection.ltr,
                keyboardType: TextInputType.emailAddress,
              ),
              verticalSpace(14),
              CustomTextFormField(
                labelText: 'كلمة المرور',
                hintText: 'أدخل كلمة المرور',
                controller: _passwordController,
                obscureText: _isObscure,
                validator: LoginValidation.password,
                readOnly: isLoading,
                suffixIcon: IconButton(
                  onPressed: isLoading ? null : _togglePasswordVisibility,
                  splashRadius: 18.r,
                  icon: Icon(
                    _isObscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: const Color(0xFFB0A4A6),
                  ),
                ),
              ),
              verticalSpace(22),
              CustomButton(text: 'تسجيل الدخول', onPressed: () => _submit(context)),
              verticalSpace(16),
              CustomSecondaryButton(
                onPressed: isLoading ? null : () {},
                hasBorder: false,
                text: 'نسيت كلمة المرور؟ تواصل مع المدرس.',
                textStyle: AppTextStyle.font13Wine200RegularTajawal(),
              ),
            ],
          ),
        );
      },
    );
  }
}
