import 'package:al_mobdea/features/profile/domain/use_cases/delete_account_use_case.dart';
import 'package:al_mobdea/features/profile/presentation/cubit/delete_account_cubit/delete_account_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit({required DeleteAccountUseCase deleteAccountUseCase})
    : _deleteAccountUseCase = deleteAccountUseCase,
      super(const DeleteAccountInitial());

  final DeleteAccountUseCase _deleteAccountUseCase;

  bool _isDeleting = false;

  Future<void> deleteAccount({required String currentPassword}) async {
    if (isClosed || _isDeleting) {
      return;
    }

    _isDeleting = true;

    emit(const DeleteAccountLoading());

    try {
      final result = await _deleteAccountUseCase(
        currentPassword: currentPassword,
      );

      if (isClosed) {
        return;
      }

      result.fold(
        (error) {
          emit(DeleteAccountFailure(error: error));
        },
        (_) {
          emit(const DeleteAccountSuccess());
        },
      );
    } finally {
      _isDeleting = false;
    }
  }

  void clearError() {
    if (isClosed || _isDeleting || state is! DeleteAccountFailure) {
      return;
    }

    emit(const DeleteAccountInitial());
  }
}
