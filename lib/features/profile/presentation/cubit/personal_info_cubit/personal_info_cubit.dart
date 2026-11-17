import 'package:al_mobdea/features/profile/domain/entities/personal_info_entity.dart';
import 'package:al_mobdea/features/profile/domain/use_cases/get_personal_info_use_case.dart';
import 'package:al_mobdea/features/profile/domain/use_cases/update_personal_info_use_case.dart';
import 'package:al_mobdea/features/profile/presentation/cubit/personal_info_cubit/personal_info_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalInfoCubit extends Cubit<PersonalInfoState> {
  PersonalInfoCubit({
    required GetPersonalInfoUseCase getPersonalInfoUseCase,
    required UpdatePersonalInfoUseCase updatePersonalInfoUseCase,
  }) : _getPersonalInfoUseCase = getPersonalInfoUseCase,
       _updatePersonalInfoUseCase = updatePersonalInfoUseCase,
       super(const PersonalInfoState());

  final GetPersonalInfoUseCase _getPersonalInfoUseCase;
  final UpdatePersonalInfoUseCase _updatePersonalInfoUseCase;

  bool _isLoading = false;

  Future<void> initialize() {
    return loadPersonalInfo();
  }

  Future<void> loadPersonalInfo() async {
    if (isClosed || _isLoading || state.isSaving) {
      return;
    }

    _isLoading = true;

    emit(state.copyWith(status: PersonalInfoStatus.loading, clearError: true));

    try {
      final result = await _getPersonalInfoUseCase();

      if (isClosed) {
        return;
      }

      result.fold(
        (error) {
          emit(
            state.copyWith(
              status: PersonalInfoStatus.loadFailure,
              error: error,
            ),
          );
        },
        (personalInfo) {
          emit(
            state.copyWith(
              status: PersonalInfoStatus.ready,
              personalInfo: personalInfo,
              clearError: true,
            ),
          );
        },
      );
    } finally {
      _isLoading = false;
    }
  }

  bool hasChanges({
    required String name,
    required String phoneNumber,
    required String email,
  }) {
    final personalInfo = state.personalInfo;

    if (personalInfo == null) {
      return false;
    }

    return name.trim() != personalInfo.name.trim() ||
        phoneNumber.trim() != personalInfo.phoneNumber.trim() ||
        email.trim().toLowerCase() != personalInfo.email.trim().toLowerCase();
  }

  Future<void> savePersonalInfo({
    required String name,
    required String phoneNumber,
    required String email,
    required String currentPassword,
  }) async {
    if (isClosed || state.isLoading || state.isSaving) {
      return;
    }

    final personalInfo = state.personalInfo;

    if (personalInfo == null) {
      return;
    }

    final normalizedName = name.trim();
    final normalizedPhoneNumber = phoneNumber.trim();
    final normalizedEmail = email.trim().toLowerCase();

    final hasUnsavedChanges = hasChanges(
      name: normalizedName,
      phoneNumber: normalizedPhoneNumber,
      email: normalizedEmail,
    );

    if (!hasUnsavedChanges) {
      return;
    }

    emit(state.copyWith(status: PersonalInfoStatus.saving, clearError: true));

    final result = await _updatePersonalInfoUseCase(
      name: normalizedName,
      phoneNumber: normalizedPhoneNumber,
      email: normalizedEmail,
      currentPassword: currentPassword,
    );

    if (isClosed) {
      return;
    }

    result.fold(
      (error) {
        emit(
          state.copyWith(status: PersonalInfoStatus.saveFailure, error: error),
        );
      },
      (_) {
        emit(
          state.copyWith(
            status: PersonalInfoStatus.saved,
            personalInfo: PersonalInfoEntity(
              studentId: personalInfo.studentId,
              name: normalizedName,
              phoneNumber: normalizedPhoneNumber,
              email: normalizedEmail,
            ),
            clearError: true,
          ),
        );
      },
    );
  }

  void consumeSaveResult() {
    if (isClosed ||
        (state.status != PersonalInfoStatus.saved &&
            state.status != PersonalInfoStatus.saveFailure)) {
      return;
    }

    emit(state.copyWith(status: PersonalInfoStatus.ready, clearError: true));
  }

  Future<void> retry() {
    return loadPersonalInfo();
  }
}
