import 'package:al_mobdea/features/profile/data/models/personal_info_model.dart';

abstract interface class PersonalInfoRemoteDataSource {
  Future<PersonalInfoModel> getPersonalInfo();

  Future<void> updatePersonalInfo({
    required String name,
    required String phoneNumber,
    required String email,
    required String currentPassword,
  });
}
