import 'package:al_mobdea/core/firebase/firestore/firestore_service.dart';
import 'package:al_mobdea/core/firebase/storage/storage_service.dart';
import 'package:al_mobdea/features/lessons/data/data_source/cache/lesson_local_data_source.dart';
import 'package:al_mobdea/features/lessons/data/data_source/cache/lesson_pdf_cache_local_data_source.dart';
import 'package:al_mobdea/features/lessons/data/data_source/cache/secure_lesson_local_data_source.dart';
import 'package:al_mobdea/features/lessons/data/data_source/cache/secure_lesson_pdf_cache_local_data_source.dart';
import 'package:al_mobdea/features/lessons/data/data_source/remote/firebase_lesson_pdf_remote_data_source.dart';
import 'package:al_mobdea/features/lessons/data/data_source/remote/firebase_lessons_remote_data_source.dart';
import 'package:al_mobdea/features/lessons/data/data_source/remote/lesson_pdf_remote_data_source.dart';
import 'package:al_mobdea/features/lessons/data/data_source/remote/lessons_remote_data_source.dart';
import 'package:al_mobdea/features/lessons/data/repositories/lesson_pdf_repository_impl.dart';
import 'package:al_mobdea/features/lessons/data/repositories/lessons_repository_impl.dart';
import 'package:al_mobdea/features/lessons/domain/repositories/lesson_pdf_repository.dart';
import 'package:al_mobdea/features/lessons/domain/repositories/lessons_repository.dart';
import 'package:al_mobdea/features/lessons/domain/use_cases/get_lesson_by_id_use_case.dart';
import 'package:al_mobdea/features/lessons/domain/use_cases/get_lesson_pdf_use_case.dart';
import 'package:al_mobdea/features/lessons/domain/use_cases/stream_lessons_use_case.dart';
import 'package:al_mobdea/features/lessons/presentation/cubit/lesson_pdf_cubit.dart';
import 'package:al_mobdea/features/lessons/presentation/cubit/lessons_cubit.dart';
import 'package:get_it/get_it.dart';

void registerLessonsDependencies(GetIt getIt) {
  getIt.registerLazySingleton<LessonsLocalDataSource>(() => const SecureLessonsLocalDataSource());
  getIt.registerLazySingleton<LessonPdfCacheLocalDataSource>(
    () => const SecureLessonPdfCacheLocalDataSource(),
  );
  getIt.registerLazySingleton<LessonsRemoteDataSource>(() { 
    return FirebaseLessonsRemoteDataSource(firestoreService: getIt<FirestoreService>());
  });
  getIt.registerLazySingleton<LessonPdfRemoteDataSource>(
    () => FirebaseLessonPdfRemoteDataSource(storageService: getIt<StorageService>()),
  );
  getIt.registerLazySingleton<LessonsRepository>(
    () => LessonsRepositoryImpl(
      localDataSource: getIt<LessonsLocalDataSource>(),
      remoteDataSource: getIt<LessonsRemoteDataSource>(),
    ),
  );
  getIt.registerLazySingleton<LessonPdfRepository>(
    () => LessonPdfRepositoryImpl(
      cacheLocalDataSource: getIt<LessonPdfCacheLocalDataSource>(),
      remoteDataSource: getIt<LessonPdfRemoteDataSource>(),
    ),
  );
  getIt.registerLazySingleton<StreamLessonsUseCase>(
    () => StreamLessonsUseCase(repository: getIt<LessonsRepository>()),
  );
  getIt.registerLazySingleton<GetLessonByIdUseCase>(
    () => GetLessonByIdUseCase(repository: getIt<LessonsRepository>()),
  );
  getIt.registerLazySingleton<GetLessonPdfUseCase>(
    () => GetLessonPdfUseCase(repository: getIt<LessonPdfRepository>()),
  );
  getIt.registerFactory<LessonsCubit>(
    () => LessonsCubit(streamLessonsUseCase: getIt<StreamLessonsUseCase>()),
  );
  getIt.registerFactory<LessonPdfCubit>(
    () => LessonPdfCubit(getLessonPdfUseCase: getIt<GetLessonPdfUseCase>()),
  );
}
