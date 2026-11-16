import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/custom_button.dart';
import 'package:al_mobdea/core/widgets/custom_text_form_field.dart';
import 'package:al_mobdea/features/profile/presentation/cubit/personal_info_cubit/personal_info_cubit.dart';
import 'package:al_mobdea/features/profile/presentation/cubit/personal_info_cubit/personal_info_state.dart';
import 'package:al_mobdea/features/profile/presentation/validation/update_profile_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalInfoForm extends StatefulWidget {
  const PersonalInfoForm({super.key, required this.state});

  final PersonalInfoState state;

  @override
  State<PersonalInfoForm> createState() {
    return _PersonalInfoFormState();
  }
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _emailController;

  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final personalInfo = widget.state.personalInfo!;

    _nameController = TextEditingController(text: personalInfo.name);

    _phoneController = TextEditingController(text: personalInfo.phoneNumber);

    _emailController = TextEditingController(text: personalInfo.email);
  }

  @override
  void didUpdateWidget(covariant PersonalInfoForm oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.state.isSaving && !widget.state.isSaving) {
      _passwordController.clear();
    }

    if (widget.state.status == PersonalInfoStatus.saved &&
        oldWidget.state.status != PersonalInfoStatus.saved) {
      final personalInfo = widget.state.personalInfo!;

      _nameController.text = personalInfo.name;
      _phoneController.text = personalInfo.phoneNumber;
      _emailController.text = personalInfo.email;
    }
  }

  void _onFieldChanged(String _) {
    setState(() {});
  }

  void _save() {
    if (widget.state.isSaving) {
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();

    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    context.read<PersonalInfoCubit>().savePersonalInfo(
      name: _nameController.text,
      phoneNumber: _phoneController.text,
      email: _emailController.text,
      currentPassword: _passwordController.text,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;

    final hasChanges = context.read<PersonalInfoCubit>().hasChanges(
      name: _nameController.text,
      phoneNumber: _phoneController.text,
      email: _emailController.text,
    );

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildDetailsCard(state),
          verticalSpace(20),
          _buildConfirmationCard(state),
          verticalSpace(24),
          CustomButton(
            text: 'حفظ التعديلات',
            isLoading: state.isSaving,
            onPressed: hasChanges && !state.isSaving ? _save : null,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard(PersonalInfoState state) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: ColorPalette.cardBackground,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: ColorPalette.border),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 22.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'معلومات الحساب',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: AppTextStyle.font16TextPrimarySemiBoldKufam(),
            ),
            verticalSpace(22),
            CustomTextFormField(
              controller: _nameController,
              labelText: 'الاسم',
              hintText: 'اكتب اسمك',
              enabled: !state.isSaving,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.name],
              autovalidateMode: AutovalidateMode.disabled,
              validator: UpdateProfileValidator.name,
              onChanged: _onFieldChanged,
            ),
            verticalSpace(18),
            CustomTextFormField(
              controller: _phoneController,
              labelText: 'رقم الهاتف',
              hintText: '01xxxxxxxxx',
              enabled: !state.isSaving,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              textDirection: TextDirection.ltr,
              autofillHints: const [AutofillHints.telephoneNumber],
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(11),
              ],
              autovalidateMode: AutovalidateMode.disabled,
              validator: UpdateProfileValidator.phoneNumber,
              onChanged: _onFieldChanged,
            ),
            verticalSpace(18),
            CustomTextFormField(
              controller: _emailController,
              labelText: 'البريد الإلكتروني',
              hintText: 'example@gmail.com',
              enabled: !state.isSaving,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              textDirection: TextDirection.ltr,
              autofillHints: const [AutofillHints.email],
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
              ],
              autovalidateMode: AutovalidateMode.disabled,
              validator: UpdateProfileValidator.email,
              onChanged: _onFieldChanged,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmationCard(PersonalInfoState state) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: ColorPalette.wine50,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: ColorPalette.wine100),
      ),
      child: Padding(
        padding: EdgeInsets.all(18.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              textDirection: TextDirection.rtl,
              children: [
                Icon(
                  Icons.lock_outline_rounded,
                  color: ColorPalette.primary,
                  size: 22.sp,
                ),
                horizontalSpace(8),
                Expanded(
                  child: Text(
                    'تأكيد التعديلات',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.right,
                    style: AppTextStyle.font14TextPrimarySemiBoldKufam(),
                  ),
                ),
              ],
            ),
            verticalSpace(8),
            Text(
              'أدخل كلمة مرور حسابك الحالية لتأكيد هويتك قبل الحفظ.',
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: AppTextStyle.font12TextSecondaryRegularTajawal().copyWith(
                height: 1.6,
              ),
            ),
            verticalSpace(16),
            CustomTextFormField(
              controller: _passwordController,
              labelText: 'كلمة المرور الحالية',
              hintText: 'أدخل كلمة المرور',
              enabled: !state.isSaving,
              isPassword: true,
              showPasswordCopyIcon: false,
              textDirection: TextDirection.ltr,
              textInputAction: TextInputAction.done,
              autovalidateMode: AutovalidateMode.disabled,
              validator: UpdateProfileValidator.currentPassword,
            ),
          ],
        ),
      ),
    );
  }
}
