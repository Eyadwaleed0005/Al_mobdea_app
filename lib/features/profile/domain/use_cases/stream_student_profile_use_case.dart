import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/profile/domain/entities/profile_entity.dart';
import 'package:al_mobdea/features/profile/domain/repositories/profile_repository.dart';
import 'package:dartz/dartz.dart';

class StreamStudentProfileUseCase {
  final ProfileRepository _repository;

  const StreamStudentProfileUseCase({required ProfileRepository repository})
    : _repository = repository;

  Stream<Either<AppErrorModel, ProfileEntity>> call() {
    return _repository.streamStudentProfile();
  }
}
