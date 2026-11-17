import 'package:al_mobdea/features/profile/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:al_mobdea/features/profile/presentation/widgets/profile_screen_widgets/profile_screen_states/profile_error_view.dart';
import 'package:al_mobdea/features/profile/presentation/widgets/profile_screen_widgets/profile_screen_states/profile_loading_view.dart';
import 'package:al_mobdea/features/profile/presentation/widgets/profile_screen_widgets/profile_screen_states/profile_success_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreenContent extends StatelessWidget {
  const ProfileScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileFailure) {
          return ProfileErrorView(
            errorMessage: state.error.message,
            onRetry: context.read<ProfileCubit>().retry,
          );
        }

        if (state is ProfileSuccess) {
          return ProfileSuccessView(profile: state.profile);
        }

        return const ProfileLoadingView();
      },
    );
  }
}
