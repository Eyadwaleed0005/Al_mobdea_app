import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/core/errors/handlers/firebase_error_handler.dart';
import 'package:al_mobdea/features/profile/data/data_source/personal_info_remote_data_source.dart';
import 'package:al_mobdea/features/profile/domain/entities/personal_info_entity.dart';
import 'package:al_mobdea/features/profile/domain/repositories/personal_info_repository.dart';
import 'package:dartz/dartz.dart';

class PersonalInfoRepositoryImpl implements PersonalInfoRepository {
  const PersonalInfoRepositoryImpl({
    required PersonalInfoRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final PersonalInfoRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppErrorModel, PersonalInfoEntity>> getPersonalInfo() async {
    try {
      final personalInfo = await _remoteDataSource.getPersonalInfo();

      return Right(personalInfo.toEntity());
    } catch (error) {
      return Left(FirebaseErrorHandler.handle(error));
    }
  }

  @override
  Future<Either<AppErrorModel, Unit>> updatePersonalInfo({
    required String name,
    required String phoneNumber,
    required String email,
    required String currentPassword,
  }) async {
    try {
      await _remoteDataSource.updatePersonalInfo(
        name: name,
        phoneNumber: phoneNumber,
        email: email,
        currentPassword: currentPassword,
      );

      return const Right(unit);
    } catch (error) {
      return Left(FirebaseErrorHandler.handle(error));
    }
  }
}
