import 'package:al_mobdea/core/firebase/firestore/firestore_service.dart';
import 'package:al_mobdea/features/profile/data/data_source/delete_account_local_data_source.dart';
import 'package:al_mobdea/features/profile/data/data_source/delete_account_remote_data_source.dart';
import 'package:al_mobdea/features/profile/data/data_source/device_delete_account_local_data_source.dart';
import 'package:al_mobdea/features/profile/data/data_source/firebase_delete_account_remote_data_source.dart';
import 'package:al_mobdea/features/profile/data/data_source/firebase_my_subscription_remote_data_source.dart';
import 'package:al_mobdea/features/profile/data/data_source/firebase_personal_info_remote_data_source.dart';
import 'package:al_mobdea/features/profile/data/data_source/firebase_profile_remote_data_source.dart';
import 'package:al_mobdea/features/profile/data/data_source/my_subscription_remote_data_source.dart';
import 'package:al_mobdea/features/profile/data/data_source/personal_info_remote_data_source.dart';
import 'package:al_mobdea/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:al_mobdea/features/profile/data/repositories/delete_account_repository_impl.dart';
import 'package:al_mobdea/features/profile/data/repositories/my_subscription_repository_impl.dart';
import 'package:al_mobdea/features/profile/data/repositories/personal_info_repository_impl.dart';
import 'package:al_mobdea/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:al_mobdea/features/profile/domain/repositories/delete_account_repository.dart';
import 'package:al_mobdea/features/profile/domain/repositories/my_subscription_repository.dart';
import 'package:al_mobdea/features/profile/domain/repositories/personal_info_repository.dart';
import 'package:al_mobdea/features/profile/domain/repositories/profile_repository.dart';
import 'package:al_mobdea/features/profile/domain/use_cases/delete_account_use_case.dart';
import 'package:al_mobdea/features/profile/domain/use_cases/get_personal_info_use_case.dart';
import 'package:al_mobdea/features/profile/domain/use_cases/stream_my_subscription_use_case.dart';
import 'package:al_mobdea/features/profile/domain/use_cases/stream_student_profile_use_case.dart';
import 'package:al_mobdea/features/profile/domain/use_cases/update_personal_info_use_case.dart';
import 'package:al_mobdea/features/profile/presentation/cubit/delete_account_cubit/delete_account_cubit.dart';
import 'package:al_mobdea/features/profile/presentation/cubit/my_subscription_cubit/my_subscription_cubit.dart';
import 'package:al_mobdea/features/profile/presentation/cubit/personal_info_cubit/personal_info_cubit.dart';
import 'package:al_mobdea/features/profile/presentation/cubit/profile_cubit/profile_cubit.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

void registerProfileDependencies(GetIt getIt) {
  _registerRemoteDataSources(getIt);
  _registerLocalDataSources(getIt);
  _registerRepositories(getIt);
  _registerUseCases(getIt);
  _registerCubits(getIt);
}

void _registerRemoteDataSources(GetIt getIt) {
  getIt.registerLazySingleton<ProfileRemoteDataSource>(
    () => FirebaseProfileRemoteDataSource(
      firestoreService: getIt<FirestoreService>(),
      firebaseAuth: getIt<FirebaseAuth>(),
    ),
  );

  getIt.registerLazySingleton<PersonalInfoRemoteDataSource>(
    () => FirebasePersonalInfoRemoteDataSource(
      firebaseAuth: getIt<FirebaseAuth>(),
      firestoreService: getIt<FirestoreService>(),
      firebaseFunctions: getIt<FirebaseFunctions>(),
    ),
  );

  getIt.registerLazySingleton<MySubscriptionRemoteDataSource>(
    () => FirebaseMySubscriptionRemoteDataSource(
      firebaseAuth: getIt<FirebaseAuth>(),
      firestoreService: getIt<FirestoreService>(),
    ),
  );

  getIt.registerLazySingleton<DeleteAccountRemoteDataSource>(
    () => FirebaseDeleteAccountRemoteDataSource(
      firebaseAuth: getIt<FirebaseAuth>(),
      firebaseFunctions: getIt<FirebaseFunctions>(),
    ),
  );
}

void _registerLocalDataSources(GetIt getIt) {
  getIt.registerLazySingleton<DeleteAccountLocalDataSource>(
    () =>
        DeviceDeleteAccountLocalDataSource(firebaseAuth: getIt<FirebaseAuth>()),
  );
}

void _registerRepositories(GetIt getIt) {
  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(dataSource: getIt<ProfileRemoteDataSource>()),
  );

  getIt.registerLazySingleton<PersonalInfoRepository>(
    () => PersonalInfoRepositoryImpl(
      remoteDataSource: getIt<PersonalInfoRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<MySubscriptionRepository>(
    () => MySubscriptionRepositoryImpl(
      remoteDataSource: getIt<MySubscriptionRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<DeleteAccountRepository>(
    () => DeleteAccountRepositoryImpl(
      remoteDataSource: getIt<DeleteAccountRemoteDataSource>(),
      localDataSource: getIt<DeleteAccountLocalDataSource>(),
    ),
  );
}

void _registerUseCases(GetIt getIt) {
  getIt.registerLazySingleton<StreamStudentProfileUseCase>(
    () => StreamStudentProfileUseCase(repository: getIt<ProfileRepository>()),
  );

  getIt.registerLazySingleton<GetPersonalInfoUseCase>(
    () => GetPersonalInfoUseCase(repository: getIt<PersonalInfoRepository>()),
  );

  getIt.registerLazySingleton<UpdatePersonalInfoUseCase>(
    () =>
        UpdatePersonalInfoUseCase(repository: getIt<PersonalInfoRepository>()),
  );

  getIt.registerLazySingleton<StreamMySubscriptionUseCase>(
    () => StreamMySubscriptionUseCase(
      repository: getIt<MySubscriptionRepository>(),
    ),
  );

  getIt.registerLazySingleton<DeleteAccountUseCase>(
    () => DeleteAccountUseCase(repository: getIt<DeleteAccountRepository>()),
  );
}

void _registerCubits(GetIt getIt) {
  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(
      streamStudentProfileUseCase: getIt<StreamStudentProfileUseCase>(),
    ),
  );

  getIt.registerFactory<PersonalInfoCubit>(
    () => PersonalInfoCubit(
      getPersonalInfoUseCase: getIt<GetPersonalInfoUseCase>(),
      updatePersonalInfoUseCase: getIt<UpdatePersonalInfoUseCase>(),
    ),
  );

  getIt.registerFactory<MySubscriptionCubit>(
    () => MySubscriptionCubit(
      streamMySubscriptionUseCase: getIt<StreamMySubscriptionUseCase>(),
    ),
  );

  getIt.registerFactory<DeleteAccountCubit>(
    () =>
        DeleteAccountCubit(deleteAccountUseCase: getIt<DeleteAccountUseCase>()),
  );
}
