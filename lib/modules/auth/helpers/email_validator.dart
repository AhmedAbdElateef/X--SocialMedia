import 'package:formz/formz.dart';
//--------------------------------

enum EmailValidationError { empty, invalid }

class EmailValidator extends FormzInput<String, String> {
  static const String _validEmailRegex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  const EmailValidator.pure() : super.pure("");

  const EmailValidator.dirty(String email) : super.dirty(email);

  @override
  String? validator(String value) {
    if (value.isEmpty) {
      return EmailValidationError.empty.toString();
    } else {
      return RegExp(_validEmailRegex).hasMatch(value)
          ? null
          : EmailValidationError.invalid.toString();
    }
  }
}
