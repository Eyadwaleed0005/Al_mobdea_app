import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';

sealed class DeleteAccountState {
  const DeleteAccountState();
}

final class DeleteAccountInitial extends DeleteAccountState {
  const DeleteAccountInitial();
}

final class DeleteAccountLoading extends DeleteAccountState {
  const DeleteAccountLoading();
}

final class DeleteAccountSuccess extends DeleteAccountState {
  const DeleteAccountSuccess();
}

final class DeleteAccountFailure extends DeleteAccountState {
  const DeleteAccountFailure({required this.error});

  final AppErrorModel error;
}
