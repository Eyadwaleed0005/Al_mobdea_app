import 'package:al_mobdea/features/authentication/data/data_source/remote/login_remote_data_source.dart';
import 'package:al_mobdea/features/authentication/data/models/login_model.dart';

/// Stands in for the Firebase login while Firebase is not initialized, so the
/// login screen can be previewed without a Firebase project.
/// remove this file when firebase is initialized
class PreviewLoginRemoteDataSource implements LoginRemoteDataSource {
  const PreviewLoginRemoteDataSource();

  @override
  Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
    return LoginModel(id: 'preview-student', email: email);
  }
}
