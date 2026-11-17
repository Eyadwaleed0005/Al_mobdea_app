import 'package:al_mobdea/core/cache/secure_storage/secure_storage.dart';
import 'package:al_mobdea/core/cache/shared_preferences/shared_preferences.dart';
import 'package:al_mobdea/features/profile/data/data_source/delete_account_local_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DeviceDeleteAccountLocalDataSource
    implements DeleteAccountLocalDataSource {
  const DeviceDeleteAccountLocalDataSource({required FirebaseAuth firebaseAuth})
    : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;

  @override
  Future<void> clearSession() async {
    await Future.wait<void>([
      SecureStorageHelper.clearAll(),
      SharedPreferencesHelper.clearAll(),
      _firebaseAuth.signOut(),
    ]);
  }
}
