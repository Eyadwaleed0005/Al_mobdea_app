import 'package:al_mobdea/app/dependency_injection/service_locator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Top-level background message handler — must be a top-level function.
@pragma('vm:entry-point')
Future<void> _firebaseNotificationBackgroundHandler(RemoteMessage message) async {
  // Handle background notification
}

abstract final class AppInitializer {
  AppInitializer._();

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations(const <DeviceOrientation>[DeviceOrientation.portraitUp]);

    await ScreenUtil.ensureScreenSize();

    // Uncomment after flutterfire configure is run:
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    //
    // FirebaseMessaging.onBackgroundMessage(
    //   _firebaseNotificationBackgroundHandler,
    // );

    setupServiceLocator();
  }
}
