import 'package:formz/formz.dart';
//--------------------------------

enum UsernameValidationError { empty, invalid }

class UsernameValidator extends FormzInput<String, String> {
  const UsernameValidator.pure() : super.pure("");

  const UsernameValidator.dirty(String userName) : super.dirty(userName);

  @override
  String? validator(String value) {
    if (value.isEmpty) {
      return UsernameValidationError.empty.toString();
    } else {
      bool validUserName = value.length >= 3;
      return validUserName ? null : UsernameValidationError.invalid.toString();
    }
  }
}
