import 'package:formz/formz.dart';
//--------------------------------

enum PasswordValidationError { empty, invalid }

class PasswordValidator extends FormzInput<String, String> {
  static const String _validPasswordRegex = r'^(?=.*?[A-Z])(?=.*?[0-9]).{8,}$';

  const PasswordValidator.pure() : super.pure("");

  const PasswordValidator.dirty(String password) : super.dirty(password);

  @override
  String? validator(String value, {bool skipEmpty = false}) {
    if (value.isEmpty) {
      return PasswordValidationError.empty.toString();
    } else {
      return RegExp(_validPasswordRegex).hasMatch(value)
          ? null
          : PasswordValidationError.invalid.toString();
    }
  }
}
