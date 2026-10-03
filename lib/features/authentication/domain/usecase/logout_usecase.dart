import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/authentication/domain/repositories/logout_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutUseCase {
  final LogoutRepository repository;

  const LogoutUseCase({required this.repository});

  Future<Either<AppErrorModel, void>> call() {
    return repository.logout();
  }
}
