import 'package:al_mobdea/app/routes/screen_routes/route_names.dart';
import 'package:al_mobdea/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

abstract final class HomeRoutes {
  const HomeRoutes._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.homeScreen:
      case RouteNames.mainNavigationScreen:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const HomeScreen(),
        );

      default:
        return null;
    }
  }
}
