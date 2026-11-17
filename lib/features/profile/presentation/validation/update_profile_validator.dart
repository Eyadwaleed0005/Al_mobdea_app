import 'package:al_mobdea/core/validation__handlers/email_handler.dart';
import 'package:al_mobdea/core/validation__handlers/name_handler.dart';
import 'package:al_mobdea/core/validation__handlers/password_handler.dart';
import 'package:al_mobdea/core/validation__handlers/phone_handler.dart';
import 'package:al_mobdea/features/authentication/presentation/validation/validation_handler.dart';

abstract final class UpdateProfileValidator {
  static final NameHandler _nameHandler = NameHandler();
  static final PhoneHandler _phoneHandler = PhoneHandler();
  static final EmailHandler _emailHandler = EmailHandler();

  static final PasswordHandler _passwordHandler = PasswordHandler(
    requireStrongPassword: false,
  );

  static String? name(String? value) {
    return _nameHandler.handle(
      ValidationRequest(field: ValidationField.name, value: value ?? ''),
    );
  }

  static String? phoneNumber(String? value) {
    return _phoneHandler.handle(
      ValidationRequest(field: ValidationField.phoneNumber, value: value ?? ''),
    );
  }

  static String? email(String? value) {
    return _emailHandler.handle(
      ValidationRequest(field: ValidationField.email, value: value ?? ''),
    );
  }

  static String? currentPassword(String? value) {
    return _passwordHandler.handle(
      ValidationRequest(field: ValidationField.password, value: value ?? ''),
    );
  }
}
