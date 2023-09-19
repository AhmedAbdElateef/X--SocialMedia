import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------
import 'package:social_x/core/ui/routes.dart';
import 'package:social_x/core/helpers/extensions/sailor.dart';
import 'package:social_x/core/constants/errors.dart';
import 'package:social_x/core/models/http_client_result.dart';
import 'package:social_x/core/helpers/functions/clients_error_handler.dart';
//----------------------------------------------------------------
import 'package:social_x/modules/auth/services/signup_client.dart';
import 'package:social_x/modules/auth/helpers/email_validator.dart';
import 'package:social_x/modules/auth/helpers/password_validator.dart';
import 'package:social_x/modules/auth/helpers/username_validator.dart';
import 'package:social_x/modules/auth/helpers/phone_number_validator.dart';
//-------------------------------------------------------------------------

final signupProvider = ChangeNotifierProvider.autoDispose((_) {
  return SignupNotifier();
});

class SignupNotifier extends ChangeNotifier {
  bool isLoading = false;
  bool passwordIsVisible = false;

  String? usernameError = "init";
  String? phoneNumberError = "init";
  String? emailError = "init";
  String? passwordError = "init";

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _client = SignupClient();

  Future<void> signup(BuildContext context) async {
    bool invalidInput = emailError != null &&
        passwordError != null &&
        usernameError != null &&
        phoneNumberError != null;

    if (invalidInput) {
      handleHttpClientError(context, AppErrors.invalidInput);
      return;
    }

    _changeLoadingState(true);

    final result = await _client.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
      phone: phoneController.text,
      userName: usernameController.text,
    );

    if (result is SuccessfulRequest) {
      Sailor.startOverFromRoute(AppRoutes.home);
    } else if (result is FailedRequest) {
      // ignore: use_build_context_synchronously
      handleHttpClientError(context, result.errorCode);
    }

    _changeLoadingState(false);
  }

  void changeValidEmailState(String newValue) {
    final emailValidation = EmailValidator.dirty(newValue);
    final newState = emailValidation.error;
    emailError = newState;
    notifyListeners();
  }

  void changeValidPasswordState(String newValue) {
    final passwordValidation = PasswordValidator.dirty(newValue);
    final newState = passwordValidation.error;
    passwordError = newState;
    notifyListeners();
  }

  void changeValidUsernameState(String newValue) {
    final usernameValidation = UsernameValidator.dirty(newValue);
    final newState = usernameValidation.error;
    usernameError = newState;
    notifyListeners();
  }

  void changeValidPhoneNumberState(String newValue) {
    final phoneNumberValidation = PhoneNumberValidator.dirty(newValue);
    final newState = phoneNumberValidation.error;
    phoneNumberError = newState;
    notifyListeners();
  }

  void changePasswordVisibility() {
    passwordIsVisible = !passwordIsVisible;
    notifyListeners();
  }

  void _changeLoadingState(bool newLoadingState) {
    isLoading = newLoadingState;
    notifyListeners();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
