import 'package:al_mobdea/features/app_startup/domain/entities/app_startup_destination.dart';
import 'package:al_mobdea/features/app_startup/domain/entities/app_version_entity.dart';
import 'package:al_mobdea/features/app_startup/domain/entities/student_access_entity.dart';
import 'package:al_mobdea/features/app_startup/domain/repositories/app_startup_repository.dart';

class ResolveAppStartupDestinationUseCase {
  const ResolveAppStartupDestinationUseCase({
    required this.repository,
  });

  final AppStartupRepository repository;

  Future<AppStartupDestination> call({
    bool ignoreOptionalUpdate = false,
  }) async {
    final updateDestination = await _resolveUpdateDestination(
      ignoreOptionalUpdate: ignoreOptionalUpdate,
    );

    if (updateDestination != null) {
      return updateDestination;
    }

    final studentId = repository.getCurrentUserId();

    if (studentId == null || studentId.trim().isEmpty) {
      return const AppStartupLoginDestination();
    }

    final studentAccessResult = await repository.getStudentAccess(
      studentId: studentId.trim(),
    );

    return studentAccessResult.fold<AppStartupDestination>(
      (_) => const AppStartupLoginDestination(),
      _resolveStudentDestination,
    );
  }

  Future<AppStartupUpdateDestination?> _resolveUpdateDestination({
    required bool ignoreOptionalUpdate,
  }) async {
    final appVersionResult = await repository.getAppVersion();

    final appVersion = appVersionResult.fold<AppVersionEntity?>(
      (_) => null,
      (version) => version,
    );

    if (appVersion == null) {
      return null;
    }

    final installedBuildResult = await repository.getInstalledBuildNumber();

    final installedBuildNumber = installedBuildResult.fold<int?>(
      (_) => null,
      (buildNumber) => buildNumber,
    );

    if (installedBuildNumber == null) {
      return null;
    }

    final hasUpdate = appVersion.hasNewerVersion(
      installedBuildNumber: installedBuildNumber,
    );

    if (!hasUpdate) {
      return null;
    }

    if (!appVersion.forceUpdate && ignoreOptionalUpdate) {
      return null;
    }

    return AppStartupUpdateDestination(
      version: appVersion,
      installedBuildNumber: installedBuildNumber,
    );
  }

  AppStartupDestination _resolveStudentDestination(
    StudentAccessEntity studentAccess,
  ) {
    final hasValidSubscription = studentAccess.hasValidSubscription(
      currentDate: DateTime.now(),
    );

    if (!hasValidSubscription) {
      return AppStartupSubscriptionExpiredDestination(
        subscriptionEndAt: studentAccess.subscriptionEndAt,
      );
    }

    return AppStartupHomeDestination(gradeId: studentAccess.gradeId);
  }
}
