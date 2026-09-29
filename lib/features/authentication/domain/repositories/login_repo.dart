import 'package:al_mobdea/core/errors/error_model/app_error_model.dart';
import 'package:al_mobdea/features/authentication/domain/entity/login_entity.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepo {
  Future<Either<AppErrorModel, LoginEntity>> login({
    required String email,
    required String password,
  });
}
