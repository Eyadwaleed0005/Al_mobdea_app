import 'package:al_mobdea/app/dependency_injection/core_dependencies.dart';
import 'package:al_mobdea/app/dependency_injection/features/app_startup_dependencies.dart';
import 'package:al_mobdea/app/dependency_injection/features/authentication_dependencies.dart';
import 'package:al_mobdea/app/dependency_injection/features/exams_dependencies.dart';
import 'package:al_mobdea/app/dependency_injection/features/live_session_dependencies.dart';
import 'package:al_mobdea/app/dependency_injection/features/lesson_quiz_dependencies.dart';
import 'package:al_mobdea/app/dependency_injection/features/lessons_dependencies.dart';
import 'package:al_mobdea/app/dependency_injection/features/main_navigation_dependencies.dart';
import 'package:al_mobdea/app/dependency_injection/features/secure_screen_dependencies.dart';
import 'package:al_mobdea/app/dependency_injection/features/study_notes_dependencies.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  registerCoreDependencies(getIt);
  registerAppStartupDependencies(getIt);
  registerAuthenticationDependencies(getIt);
  registerLiveSessionDependencies(getIt);
  registerLessonsDependencies(getIt);
  registerLessonQuizDependencies(getIt);
  registerStudyNotesDependencies(getIt);
  registerExamsDependencies(getIt);
  registerMainNavigationDependencies(getIt);
  registerSecureScreenDependencies(getIt);
}

