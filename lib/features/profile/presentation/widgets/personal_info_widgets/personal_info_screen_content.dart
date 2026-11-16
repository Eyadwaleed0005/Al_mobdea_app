import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/style/textstyles.dart';
import 'package:al_mobdea/core/widgets/custom_app_bar.dart';
import 'package:al_mobdea/core/widgets/custom_operation_result_dialog.dart';
import 'package:al_mobdea/features/profile/presentation/cubit/personal_info_cubit/personal_info_cubit.dart';
import 'package:al_mobdea/features/profile/presentation/cubit/personal_info_cubit/personal_info_state.dart';
import 'package:al_mobdea/features/profile/presentation/widgets/personal_info_widgets/personal_info_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalInfoScreenContent extends StatelessWidget {
  const PersonalInfoScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonalInfoCubit, PersonalInfoState>(
      listenWhen: (previous, current) {
        return previous.status != current.status &&
            (current.status == PersonalInfoStatus.saved ||
                current.status == PersonalInfoStatus.saveFailure);
      },
      listener: (context, state) {
        final isSuccess = state.status == PersonalInfoStatus.saved;

        showDialog<void>(
          context: context,
          builder: (dialogContext) {
            return CustomOperationResultDialog(
              type: isSuccess
                  ? CustomOperationResultType.success
                  : CustomOperationResultType.failure,
              title: isSuccess ? 'تم حفظ البيانات' : 'تعذر تعديل البيانات',
              message: isSuccess
                  ? 'تم تحديث بياناتك الشخصية بنجاح.'
                  : state.error!.message,
              actionText: 'حسنًا',
              onActionPressed: () {
                Navigator.of(dialogContext).pop();
              },
            );
          },
        );
      },
      builder: (context, state) {
        return PopScope(
          canPop: !state.isSaving,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                verticalSpace(12),
                AbsorbPointer(
                  absorbing: state.isSaving,
                  child: CustomAppBar(
                    title: 'البيانات الشخصية',
                    backgroundColor: Colors.transparent,
                    showBackButton: true,
                  ),
                ),
                verticalSpace(28),
                Text(
                  'بياناتك على المبدع',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: AppTextStyle.font22TextPrimarySemiBoldKufam(),
                ),
                verticalSpace(8),
                Text(
                  'حدّث بياناتك، وأكّد كلمة المرور لحفظ التعديلات.',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: AppTextStyle.font14TextSecondaryRegularTajawal()
                      .copyWith(height: 1.6),
                ),
                verticalSpace(24),
                _buildBody(context, state),
                SizedBox(
                  height: 40.h + MediaQuery.viewPaddingOf(context).bottom,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, PersonalInfoState state) {
    if (state.isLoading) {
      return _buildLoading();
    }

    if (state.status == PersonalInfoStatus.loadFailure) {
      return _buildError(context, state);
    }

    final personalInfo = state.personalInfo;

    if (personalInfo == null) {
      return const SizedBox.shrink();
    }

    return PersonalInfoForm(
      key: ValueKey(personalInfo.studentId),
      state: state,
    );
  }

  Widget _buildError(BuildContext context, PersonalInfoState state) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.h),
      child: Column(
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: ColorPalette.error,
            size: 42.sp,
          ),
          verticalSpace(16),
          Text(
            state.error!.message,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: AppTextStyle.font14TextSecondaryRegularTajawal(),
          ),
          verticalSpace(12),
          TextButton(
            onPressed: () {
              context.read<PersonalInfoCubit>().retry();
            },
            style: TextButton.styleFrom(foregroundColor: ColorPalette.primary),
            child: const Text('إعادة المحاولة'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var index = 0; index < 3; index++) ...[
          SizedBox(
            height: 76.h,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: const Color(0xFFE8E8E8),
                borderRadius: BorderRadius.circular(18.r),
              ),
            ),
          ),
          verticalSpace(18),
        ],
        verticalSpace(8),
        SizedBox(
          height: 140.h,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: const Color(0xFFE8E8E8),
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
        ),
      ],
    );
  }
}
