import 'package:al_mobdea/app/dependency_injection/core_dependencies.dart';
import 'package:al_mobdea/app/dependency_injection/features/app_startup_dependencies.dart';
import 'package:al_mobdea/app/dependency_injection/features/authentication_dependencies.dart';
import 'package:al_mobdea/app/dependency_injection/features/live_session_dependencies.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  registerCoreDependencies(getIt);
  registerAppStartupDependencies(getIt);
  registerAuthenticationDependencies(getIt);
  registerLiveSessionDependencies(getIt);
}
