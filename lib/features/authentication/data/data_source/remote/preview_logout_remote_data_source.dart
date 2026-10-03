import 'package:al_mobdea/features/authentication/data/data_source/remote/logout_remote_data_source.dart';

/// Stands in for the Firebase logout while Firebase is not initialized, so the
/// logout flow can be previewed without a Firebase project.
/// remove this file when firebase is initialized
class PreviewLogoutRemoteDataSource implements LogoutRemoteDataSource {
  const PreviewLogoutRemoteDataSource();

  @override
  Future<void> logout() async {}
}
