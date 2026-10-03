// import 'package:al_mobdea/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> firebaseNotificationBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      // TODO: uncomment when ready to use firebase
      // options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
