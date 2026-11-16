import 'package:al_mobdea/features/authentication/presentation/validation/validation_handler.dart';

class NameHandler extends ValidationHandler {
  static final RegExp _nameRegExp = RegExp(r'^[ء-غف-يa-zA-Z\s]+$');

  @override
  String? handle(ValidationRequest request) {
    if (request.field != ValidationField.name) {
      return super.handle(request);
    }

    final name = request.value.trim();

    if (name.isEmpty) {
      return 'من فضلك اكتب اسم الطالب';
    }

    if (!_nameRegExp.hasMatch(name)) {
      return 'اسم الطالب يجب أن يحتوي على حروف فقط';
    }

    return super.handle(request);
  }
}
