import 'package:al_mobdea/core/firebase/firestore/firestore_service.dart';
import 'package:al_mobdea/features/main_navigation/data/data_sources/cache/secure_student_grade_local_data_source.dart';
import 'package:al_mobdea/features/main_navigation/data/data_sources/cache/student_grade_local_data_source.dart';
import 'package:al_mobdea/features/main_navigation/data/data_sources/remote/firebase_student_grade_remote_data_source.dart';
import 'package:al_mobdea/features/main_navigation/data/data_sources/remote/preview_student_grade_remote_data_source.dart';
import 'package:al_mobdea/features/main_navigation/data/data_sources/remote/student_grade_remote_data_source.dart';
import 'package:al_mobdea/features/main_navigation/data/repositories/student_grade_repository_impl.dart';
import 'package:al_mobdea/features/main_navigation/domain/repositories/student_grade_repository.dart';
import 'package:al_mobdea/features/main_navigation/domain/use_case/stream_student_grade_id_use_case.dart';
import 'package:al_mobdea/features/main_navigation/presentation/cubit/bottom_navigation_cubit.dart';
import 'package:al_mobdea/features/main_navigation/presentation/cubit/student_grade_sync_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

void registerMainNavigationDependencies(GetIt getIt) {
  getIt.registerLazySingleton<StudentGradeLocalDataSource>(
    () => const SecureStudentGradeLocalDataSource(),
  );

  getIt.registerLazySingleton<StudentGradeRemoteDataSource>(() {
    //TODO: remove this when firebase is initialized
    if (Firebase.apps.isEmpty) {
      return const PreviewStudentGradeRemoteDataSource();
    }

    return FirebaseStudentGradeRemoteDataSource(
      firebaseAuth: getIt<FirebaseAuth>(),
      firestoreService: getIt<FirestoreService>(),
    );
  });

  getIt.registerLazySingleton<StudentGradeRepository>(
    () => StudentGradeRepositoryImpl(
      remoteDataSource: getIt<StudentGradeRemoteDataSource>(),
      localDataSource: getIt<StudentGradeLocalDataSource>(),
    ),
  );

  getIt.registerLazySingleton<StreamStudentGradeIdUseCase>(
    () => StreamStudentGradeIdUseCase(repository: getIt<StudentGradeRepository>()),
  );

  getIt.registerFactory<BottomNavigationCubit>(BottomNavigationCubit.new);
  getIt.registerFactory<StudentGradeSyncCubit>(
    () => StudentGradeSyncCubit(streamStudentGradeIdUseCase: getIt<StreamStudentGradeIdUseCase>()),
  );
}
