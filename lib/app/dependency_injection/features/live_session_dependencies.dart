import 'package:al_mobdea/core/firebase/firestore/firestore_service.dart';
import 'package:al_mobdea/features/live_session/data/data_source/firebase_live_session_remote_data_source.dart';
import 'package:al_mobdea/features/live_session/data/data_source/live_session_remote_data_source.dart';
import 'package:al_mobdea/features/live_session/data/repositories/live_session_repository_impl.dart';
import 'package:al_mobdea/features/live_session/domain/repositories/live_session_repository.dart';
import 'package:al_mobdea/features/live_session/domain/use_cases/get_live_session_use_case.dart';
import 'package:al_mobdea/features/live_session/presentation/cubits/live_session_cubit/live_session_cubit.dart';
import 'package:get_it/get_it.dart';

void registerLiveSessionDependencies(GetIt getIt) {
  getIt.registerLazySingleton<LiveSessionRemoteDataSource>(
    () => FirebaseLiveSessionRemoteDataSource(
      firestoreService: getIt<FirestoreService>(),
    ),
  );

  getIt.registerLazySingleton<LiveSessionRepository>(
    () => LiveSessionRepositoryImpl(
      remoteDataSource: getIt<LiveSessionRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<GetLiveSessionUseCase>(
    () => GetLiveSessionUseCase(repository: getIt<LiveSessionRepository>()),
  );

  getIt.registerFactory<LiveSessionCubit>(
    () => LiveSessionCubit(
      getLiveSessionUseCase: getIt<GetLiveSessionUseCase>(),
    ),
  );
}
