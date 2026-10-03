import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/core/errors/handlers/firebase_error_handler.dart';
import 'package:al_mobdea/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:al_mobdea/features/profile/domain/entities/profile_entity.dart';
import 'package:al_mobdea/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _dataSource;

  const ProfileRepositoryImpl({required ProfileRemoteDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Stream<Either<AppErrorModel, ProfileEntity>> streamStudentProfile() async* {
    try {
      await for (final profileModel in _dataSource.streamStudentProfile()) {
        yield Right(profileModel.toEntity());
      }
    } catch (error) {
      yield Left(FirebaseErrorHandler.handle(error));
    }
  }
}
