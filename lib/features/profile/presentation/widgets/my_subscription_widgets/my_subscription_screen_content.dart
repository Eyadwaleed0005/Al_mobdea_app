import 'package:al_mobdea/core/helper/spacer.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/core/widgets/app_error_state.dart';
import 'package:al_mobdea/core/widgets/custom_app_bar.dart';
import 'package:al_mobdea/features/profile/domain/entities/my_subscription_entity.dart';
import 'package:al_mobdea/features/profile/presentation/cubit/my_subscription_cubit/my_subscription_cubit.dart';
import 'package:al_mobdea/features/profile/presentation/cubit/my_subscription_cubit/my_subscription_state.dart';
import 'package:al_mobdea/features/profile/presentation/widgets/my_subscription_widgets/my_subscription_details_card.dart';
import 'package:al_mobdea/features/profile/presentation/widgets/my_subscription_widgets/my_subscription_loading_skeleton.dart';
import 'package:al_mobdea/features/profile/presentation/widgets/my_subscription_widgets/my_subscription_status_card.dart';
import 'package:al_mobdea/features/profile/presentation/widgets/my_subscription_widgets/my_subscription_support_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MySubscriptionScreenContent extends StatelessWidget {
  const MySubscriptionScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CustomAppBar(
            title: 'اشتراكي',
            backgroundColor: Colors.transparent,
            showBackButton: true,
          ),
          verticalSpace(24),
          Expanded(
            child: BlocBuilder<MySubscriptionCubit, MySubscriptionState>(
              builder: (context, state) {
                if (state is MySubscriptionFailure) {
                  return AppErrorState(
                    message: state.error.message,
                    onRetry: () {
                      context.read<MySubscriptionCubit>().retry();
                    },
                  );
                }

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: state is MySubscriptionSuccess
                      ? _buildContent(state.subscription)
                      : const MySubscriptionLoadingSkeleton(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(MySubscriptionEntity subscription) {
    final hasDates =
        subscription.subscriptionStartAt != null ||
        subscription.subscriptionEndAt != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MySubscriptionStatusCard(isActive: subscription.isActive),
        if (hasDates) ...[
          verticalSpace(20),
          MySubscriptionDetailsCard(subscription: subscription),
        ],
        verticalSpace(28),
        const Divider(height: 1, color: ColorPalette.divider),
        verticalSpace(28),
        const MySubscriptionSupportSection(),
      ],
    );
  }
}
