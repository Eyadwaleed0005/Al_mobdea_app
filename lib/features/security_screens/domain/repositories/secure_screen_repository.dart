import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:dartz/dartz.dart';

abstract interface class SecureScreenRepository {
  Future<Either<AppErrorModel, void>> enableSecureScreen();

  Future<Either<AppErrorModel, void>> disableSecureScreen();
}
