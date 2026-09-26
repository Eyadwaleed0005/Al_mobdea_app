import 'package:al_mobdea/app/al_mobdea_app.dart';
import 'package:al_mobdea/app/app_initializer.dart';
import 'package:al_mobdea/core/services/device_preview_service.dart';

Future<void> main() async {
  await AppInitializer.initialize();
  DevicePreviewService.run(child: const AlMobdeaApp());
}
