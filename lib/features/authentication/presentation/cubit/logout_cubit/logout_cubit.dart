import 'package:al_mobdea/features/authentication/domain/usecase/logout_usecase.dart';
import 'package:al_mobdea/features/authentication/presentation/cubit/logout_cubit/logout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final LogoutUseCase logoutUseCase;

  LogoutCubit({
    required this.logoutUseCase,
  }) : super(const LogoutInitial());

  bool _isLoggingOut = false;

  bool get _canEmit => !isClosed;

  Future<void> logout() async {
    if (_isLoggingOut || !_canEmit) {
      return;
    }

    _isLoggingOut = true;

    try {
      emit(const LogoutLoading());

      final logoutResult = await logoutUseCase();

      if (!_canEmit) {
        return;
      }

      logoutResult.fold(
        (error) {
          if (_canEmit) {
            emit(LogoutFailure(error: error));
          }
        },
        (_) {
          if (_canEmit) {
            emit(const LogoutSuccess());
          }
        },
      );
    } finally {
      _isLoggingOut = false;
    }
  }

  Future<void> retry() {
    return logout();
  }
}
