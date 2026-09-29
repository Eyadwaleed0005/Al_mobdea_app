import 'package:al_mobdea/app/dependency_injection/service_locator.dart';
import 'package:al_mobdea/core/helper/app_system_ui.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/features/authentication/presentation/cubit/logout_cubit/logout_cubit.dart';
import 'package:al_mobdea/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:al_mobdea/features/profile/presentation/widgets/profile_background.dart';
import 'package:al_mobdea/features/profile/presentation/widgets/profile_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileCubit>(
          create: (_) => getIt<ProfileCubit>()..initialize(),
        ),
        BlocProvider<LogoutCubit>(create: (_) => getIt<LogoutCubit>()),
      ],
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: AppSystemUi.dark(),
        child: Scaffold(
          extendBody: true,
          backgroundColor: ColorPalette.background,
          body: ProfileBackground(
            child: SafeArea(
              bottom: false,
              child: const ProfileScreenContent(),
            ),
          ),
        ),
      ),
    );
  }
}
