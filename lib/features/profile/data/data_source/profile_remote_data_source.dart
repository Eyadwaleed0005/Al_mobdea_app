import 'package:al_mobdea/features/profile/data/models/profile_model.dart';

abstract interface class ProfileRemoteDataSource {
  Stream<ProfileModel> streamStudentProfile();
}
