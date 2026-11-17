import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/profile/domain/repositories/delete_account_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteAccountUseCase {
  const DeleteAccountUseCase({required DeleteAccountRepository repository})
    : _repository = repository;

  final DeleteAccountRepository _repository;

  Future<Either<AppErrorModel, Unit>> call({required String currentPassword}) {
    return _repository.deleteAccount(currentPassword: currentPassword);
  }
}
