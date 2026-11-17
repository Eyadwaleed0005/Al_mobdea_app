import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/profile/domain/entities/personal_info_entity.dart';

enum PersonalInfoStatus {
  initial,
  loading,
  ready,
  saving,
  saved,
  loadFailure,
  saveFailure,
}

class PersonalInfoState {
  const PersonalInfoState({
    this.status = PersonalInfoStatus.initial,
    this.personalInfo,
    this.error,
  });

  final PersonalInfoStatus status;
  final PersonalInfoEntity? personalInfo;
  final AppErrorModel? error;

  bool get isLoading {
    return status == PersonalInfoStatus.initial ||
        status == PersonalInfoStatus.loading;
  }

  bool get isSaving {
    return status == PersonalInfoStatus.saving;
  }

  PersonalInfoState copyWith({
    PersonalInfoStatus? status,
    PersonalInfoEntity? personalInfo,
    AppErrorModel? error,
    bool clearError = false,
  }) {
    return PersonalInfoState(
      status: status ?? this.status,
      personalInfo: personalInfo ?? this.personalInfo,
      error: clearError ? null : error ?? this.error,
    );
  }
}
