import 'dart:async';

import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/profile/domain/entities/my_subscription_entity.dart';
import 'package:al_mobdea/features/profile/domain/use_cases/stream_my_subscription_use_case.dart';
import 'package:al_mobdea/features/profile/presentation/cubit/my_subscription_cubit/my_subscription_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MySubscriptionCubit extends Cubit<MySubscriptionState> {
  MySubscriptionCubit({
    required StreamMySubscriptionUseCase streamMySubscriptionUseCase,
  }) : _streamMySubscriptionUseCase = streamMySubscriptionUseCase,
       super(const MySubscriptionInitial());

  final StreamMySubscriptionUseCase _streamMySubscriptionUseCase;

  StreamSubscription<Either<AppErrorModel, MySubscriptionEntity>>?
  _subscription;

  bool _isInitializing = false;
  bool _isClosing = false;

  bool get _canEmit => !_isClosing && !isClosed;

  Future<void> initialize() async {
    if (_isInitializing || !_canEmit) {
      return;
    }

    _isInitializing = true;

    try {
      await _cancelSubscription();

      if (!_canEmit) {
        return;
      }

      emit(const MySubscriptionLoading());

      _subscription = _streamMySubscriptionUseCase().listen(_handleResult);
    } finally {
      _isInitializing = false;
    }
  }

  void _handleResult(Either<AppErrorModel, MySubscriptionEntity> result) {
    if (!_canEmit) {
      return;
    }

    result.fold(
      (error) {
        emit(MySubscriptionFailure(error: error));
      },
      (subscription) {
        emit(MySubscriptionSuccess(subscription: subscription));
      },
    );
  }

  Future<void> retry() {
    return initialize();
  }

  Future<void> _cancelSubscription() async {
    final subscription = _subscription;
    _subscription = null;

    await subscription?.cancel();
  }

  @override
  Future<void> close() async {
    if (_isClosing || isClosed) {
      return;
    }

    _isClosing = true;

    await _cancelSubscription();
    await super.close();
  }
}
