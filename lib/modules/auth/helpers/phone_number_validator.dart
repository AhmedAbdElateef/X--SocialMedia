import 'package:formz/formz.dart';
//--------------------------------

enum PhoneNumberValidationError { empty, invalid }

class PhoneNumberValidator extends FormzInput<String, String> {
  const PhoneNumberValidator.pure() : super.pure("");

  const PhoneNumberValidator.dirty(String number) : super.dirty(number);

  @override
  String? validator(String value) {
    if (value.isEmpty) {
      return PhoneNumberValidationError.empty.toString();
    } else {
      bool validNumber = value.length == 11 && value.startsWith("01");
      return validNumber ? null : PhoneNumberValidationError.invalid.toString();
    }
  }
}
