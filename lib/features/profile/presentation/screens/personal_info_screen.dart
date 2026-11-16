import 'package:al_mobdea/app/dependency_injection/service_locator.dart';
import 'package:al_mobdea/core/helper/app_system_ui.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/features/profile/presentation/cubit/personal_info_cubit/personal_info_cubit.dart';
import 'package:al_mobdea/features/profile/presentation/widgets/personal_info_widgets/personal_info_screen_content.dart';
import 'package:al_mobdea/features/profile/presentation/widgets/profile_screen_widgets/profile_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PersonalInfoCubit>(
      create: (_) => getIt<PersonalInfoCubit>()..initialize(),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppSystemUi.dark(),
        child: Scaffold(
          extendBody: true,
          backgroundColor: ColorPalette.background,
          body: ProfileBackground(
            child: SafeArea(
              bottom: false,
              child: const PersonalInfoScreenContent(),
            ),
          ),
        ),
      ),
    );
  }
}
