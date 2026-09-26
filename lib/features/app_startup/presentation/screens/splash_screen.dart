import 'package:al_mobdea/app/routes/app_images_routes.dart';
import 'package:al_mobdea/core/helper/app_system_ui.dart';
import 'package:al_mobdea/core/style/app_color.dart';
import 'package:al_mobdea/features/app_startup/presentation/widgets/splash_screen_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppSystemUi.dark(),
      child: Scaffold(
        backgroundColor: ColorPalette.deepSurface,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(AppImage().splashBackground, fit: BoxFit.cover),
            const SplashScreenContent(),
          ],
        ),
      ),
    );
  }
}
