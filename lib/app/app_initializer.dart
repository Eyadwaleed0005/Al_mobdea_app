import 'package:al_mobdea/app/dependency_injection/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Top-level background message handler
@pragma('vm:entry-point')
Future<void> _firebaseNotificationBackgroundHandler(dynamic message) async {
  // Handle background notification when Firebase is active
}

abstract final class AppInitializer {
  AppInitializer._();

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations(const <DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);

    await ScreenUtil.ensureScreenSize();

    // TODO: سيتم تفعيل فايربيز بعد ربط المشروع بواسطة التيم ليدر
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    // FirebaseMessaging.onBackgroundMessage(
    //   _firebaseNotificationBackgroundHandler,
    // );

    setupServiceLocator();
  }
}
