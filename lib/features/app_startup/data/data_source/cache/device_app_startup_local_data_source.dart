import 'package:al_mobdea/features/app_startup/data/data_source/cache/app_startup_local_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceAppStartupLocalDataSource implements AppStartupLocalDataSource {
  const DeviceAppStartupLocalDataSource({required this.firebaseAuth});

  final FirebaseAuth firebaseAuth;

  @override
  String? getCurrentUserId() {
    try {
      final userId = firebaseAuth.currentUser?.uid.trim();

      if (userId == null || userId.isEmpty) {
        return null;
      }

      return userId;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<int> getInstalledBuildNumber() async {
    final packageInfo = await PackageInfo.fromPlatform();

    final buildNumber = int.tryParse(packageInfo.buildNumber.trim());

    if (buildNumber == null) {
      throw const FormatException('Invalid application build number.');
    }

    return buildNumber;
  }
}
