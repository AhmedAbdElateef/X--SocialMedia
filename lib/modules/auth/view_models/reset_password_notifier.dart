import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------
import 'package:social_x/core/helpers/extensions/sailor.dart';
import 'package:social_x/core/constants/errors.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
import 'package:social_x/core/helpers/functions/clients_error_handler.dart';
//----------------------------------------------------------------
import 'package:social_x/modules/auth/helpers/email_validator.dart';
import 'package:social_x/modules/auth/services/reset_password_client.dart';
//-------------------------------------------------------------------------

final resetPasswordProvider = ChangeNotifierProvider.autoDispose((_) {
  return ResetPasswordNotifier();
});

class ResetPasswordNotifier extends ChangeNotifier {
  bool isLoading = false;
  String? error = "init";

  final emailController = TextEditingController();
  final _resetPasswordClient = ResetPasswordClient();

  String get email => emailController.text.trim();

  Future<void> rqusetPasswordReset(BuildContext context) async {
    bool invalidInput = error != null;
    if (invalidInput) {
      handleHttpClientError(context, AppErrors.invalidInput);
      return;
    }

    _changeLoadingState(true);

    try {
      await _resetPasswordClient.requestPasswordReset(email);
      Sailor.back();

      // ignore: use_build_context_synchronously
      Fluttertoast.showToast(msg: context.localizations.verificationCodeSent);
    } catch (_) {
      // ignore: use_build_context_synchronously
      handleHttpClientError(context, AppErrors.networkError);
    }

    _changeLoadingState(false);
  }

  void changeValidEmailState(String newValue) {
    final emailValidation = EmailValidator.dirty(newValue);
    final newState = emailValidation.error;
    error = newState;
    notifyListeners();
  }

  void _changeLoadingState(bool newLoadingState) {
    isLoading = newLoadingState;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
