import 'package:flutter/material.dart';

abstract final class AppRoutes {
  const AppRoutes._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    return _buildUnknownRoute(settings);
  }

  static Route<dynamic> _buildUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute<void>(
      settings: settings,
      builder: (_) {
        return const Scaffold(
          body: Center(child: Text('الصفحة المطلوبة غير موجودة', textDirection: TextDirection.rtl)),
        );
      },
    );
  }
}
