import 'package:al_mobdea/app/routes/screen_routes/route_names.dart';
import 'package:al_mobdea/features/main_navigation/presentation/screens/main_navigation_screen.dart';
import 'package:flutter/material.dart';

abstract final class MainNavigationRoutes {
  const MainNavigationRoutes._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    if (settings.name != RouteNames.mainNavigationScreen) return null;

    final initialIndex = settings.arguments is int
        ? settings.arguments! as int
        : 2;

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => MainNavigationScreen(initialIndex: initialIndex),
    );
  }
}
