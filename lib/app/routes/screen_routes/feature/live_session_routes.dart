import 'package:al_mobdea/app/routes/screen_routes/route_names.dart';
import 'package:al_mobdea/features/live_session/presentation/screens/live_session_screen.dart';
import 'package:flutter/material.dart';

abstract final class LiveSessionRoutes {
  const LiveSessionRoutes._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    if (settings.name != RouteNames.liveSessionScreen) return null;

    final arguments = settings.arguments;
    if (arguments is! String || arguments.trim().isEmpty) {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (_) => const Scaffold(
          body: Center(child: Text('تعذر فتح البث المباشر', textDirection: TextDirection.rtl)),
        ),
      );
    }

    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) => LiveSessionScreen(gradeId: arguments.trim()),
    );
  }
}
