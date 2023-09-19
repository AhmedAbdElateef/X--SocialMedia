import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------
import 'package:social_x/core/ui/routes.dart';
import 'package:social_x/core/helpers/extensions/sailor.dart';
import 'package:social_x/core/constants/errors.dart';
import 'package:social_x/core/models/http_client_result.dart';
import 'package:social_x/core/helpers/functions/clients_error_handler.dart';
//----------------------------------------------------------------
import 'package:social_x/modules/auth/helpers/email_validator.dart';
import 'package:social_x/modules/auth/helpers/password_validator.dart';
import 'package:social_x/modules/auth/services/login_methods/abstract.dart';
//--------------------------------------------------------------------------

final loginProvider = ChangeNotifierProvider.autoDispose((_) {
  return LoginNotifier();
});

class LoginNotifier extends ChangeNotifier {
  bool isLoading = false;
  bool passwordIsVisible = false;

  String? emailError = "init";
  String? passwordError = "init";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String get email => emailController.text.trim();
  String get password => passwordController.text.trim();

  Future<void> login({
    required BuildContext context,
    required LoginMethod method,
  }) async {
    bool invalidInput = emailError != null || passwordError != null;
    if (method is EmailLogin && invalidInput) {
      handleHttpClientError(context, AppErrors.invalidInput);
      return;
    }

    _changeLoadingState(true);

    final loginResult = await method.login();

    if (loginResult is SuccessfulRequest) {
      Sailor.startOverFromRoute(AppRoutes.home);
    } else if (loginResult is FailedRequest) {
      // ignore: use_build_context_synchronously
      handleHttpClientError(context, loginResult.errorCode);
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
