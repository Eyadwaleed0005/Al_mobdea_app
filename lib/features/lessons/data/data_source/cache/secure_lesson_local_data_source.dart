import 'package:al_mobdea/core/cache/secure_storage/secure_storage.dart';
import 'package:al_mobdea/core/cache/secure_storage/secure_storage_keys.dart';
import 'package:al_mobdea/features/lessons/data/data_source/cache/lesson_local_data_source.dart';

class SecureLessonsLocalDataSource implements LessonsLocalDataSource {
  const SecureLessonsLocalDataSource();

  @override
  Future<String?> getGradeId() {
    return SecureStorageHelper.getString(key: SecureStorageKeys.gradeId);
  }
}
