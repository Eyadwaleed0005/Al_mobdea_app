import 'dart:async';

import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/profile/domain/entities/profile_entity.dart';
import 'package:al_mobdea/features/profile/domain/use_cases/stream_student_profile_use_case.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final StreamStudentProfileUseCase _streamStudentProfileUseCase;

  ProfileCubit({required StreamStudentProfileUseCase streamStudentProfileUseCase})
    : _streamStudentProfileUseCase = streamStudentProfileUseCase,
      super(const ProfileInitial());

  StreamSubscription<Either<AppErrorModel, ProfileEntity>>?
  _profileSubscription;

  bool _isInitializing = false;
  bool _isClosing = false;

  bool get _canEmit => !_isClosing && !isClosed;

  Future<void> initialize() async {
    if (_isInitializing || !_canEmit) return;

    _isInitializing = true;

    try {
      await _cancelProfileSubscription();

      if (!_canEmit) return;

      emit(const ProfileLoading());

      _profileSubscription = _streamStudentProfileUseCase().listen(
        _onProfileResult,
      );
    } finally {
      _isInitializing = false;
    }
  }

  Future<void> retry() {
    return initialize();
  }

  void _onProfileResult(Either<AppErrorModel, ProfileEntity> result) {
    if (!_canEmit) return;

    result.fold(_emitFailure, _emitSuccess);
  }

  void _emitSuccess(ProfileEntity profile) {
    if (!_canEmit) return;

    emit(ProfileSuccess(profile: profile));
  }

  void _emitFailure(AppErrorModel error) {
    if (!_canEmit) return;

    emit(ProfileFailure(error: error));
  }

  Future<void> _cancelProfileSubscription() async {
    await _profileSubscription?.cancel();
    _profileSubscription = null;
  }

  @override
  Future<void> close() async {
    if (_isClosing || isClosed) return;
    _isClosing = true;
    await _cancelProfileSubscription();

    return super.close();
  }
}
