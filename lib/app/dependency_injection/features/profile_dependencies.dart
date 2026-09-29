import 'package:al_mobdea/core/firebase/firestore/firestore_service.dart';
import 'package:al_mobdea/features/profile/data/data_source/firebase_profile_remote_data_source.dart';
import 'package:al_mobdea/features/profile/data/data_source/preview_profile_remote_data_source.dart';
import 'package:al_mobdea/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:al_mobdea/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:al_mobdea/features/profile/domain/repositories/profile_repository.dart';
import 'package:al_mobdea/features/profile/domain/use_cases/stream_student_profile_use_case.dart';
import 'package:al_mobdea/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

void registerProfileDependencies(GetIt getIt) {
  _registerRemoteDataSources(getIt);
  _registerRepositories(getIt);
  _registerUseCases(getIt);
  _registerCubits(getIt);
}

void _registerRemoteDataSources(GetIt getIt) {
  getIt.registerLazySingleton<ProfileRemoteDataSource>(() {
    //TODO: remove this when firebase is initialized
    if (Firebase.apps.isEmpty) {
      return const PreviewProfileRemoteDataSource();
    }

    return FirebaseProfileRemoteDataSource(
      firestoreService: getIt<FirestoreService>(),
      firebaseAuth: getIt<FirebaseAuth>(),
    );
  });
}

void _registerRepositories(GetIt getIt) {
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(dataSource: getIt<ProfileRemoteDataSource>()),
  );
}

void _registerUseCases(GetIt getIt) {
  getIt.registerLazySingleton<StreamStudentProfileUseCase>(
    () => StreamStudentProfileUseCase(repository: getIt<ProfileRepository>()),
  );
}

void _registerCubits(GetIt getIt) {
  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(streamStudentProfileUseCase: getIt<StreamStudentProfileUseCase>()),
  );
}
