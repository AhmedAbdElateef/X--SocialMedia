import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------
import 'package:social_x/core/helpers/extensions/sailor.dart';
import 'package:social_x/core/ui/components/input/x_text_field.dart';
import 'package:social_x/core/ui/components/buttons/action_button.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
import 'package:social_x/core/ui/components/loaders/loading_overlay.dart';
//----------------------------------------------------------------
import 'package:social_x/modules/auth/views/widgets/auth_body.dart';
import 'package:social_x/modules/auth/view_models/signup_notifier.dart';
//----------------------------------------------------------------------

class SignupScreen extends ConsumerWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(signupProvider);
    final watcher = ref.watch(signupProvider);
    return SafeArea(
      child: LoadingOverlay(
        loading: watcher.isLoading,
        child: Scaffold(
          body: AuthBody(
            children: [
              const SizedBox(height: 20.0),
              Text(
                context.localizations.signUp.toUpperCase(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                context.localizations.signupSlogan,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 33.0),
              XTextField(
                controller: notifier.usernameController,
                hintText: context.localizations.userName,
                errorText: context.localizations.usernameError(
                  watcher.usernameError ?? "",
                ),
                inputType: TextInputType.name,
                onChanged: (String newValue) {
                  notifier.changeValidUsernameState(newValue);
                },
              ),
              const SizedBox(height: 24.0),
              XTextField(
                controller: notifier.phoneController,
                hintText: context.localizations.phoneNumber,
                allowDigitsOnly: true,
                inputType: TextInputType.phone,
                errorText: context.localizations.phonenumberError(
                  watcher.phoneNumberError ?? "",
                ),
                onChanged: (String newValue) {
                  notifier.changeValidPhoneNumberState(newValue);
                },
              ),
              const SizedBox(height: 24.0),
              XTextField(
                controller: notifier.emailController,
                hintText: context.localizations.email,
                errorText: context.localizations.emailError(
                  watcher.emailError ?? "",
                ),
                inputType: TextInputType.emailAddress,
                onChanged: (String newValue) {
                  notifier.changeValidEmailState(newValue);
                },
              ),
              const SizedBox(height: 24.0),
              XTextField(
                secret: !watcher.passwordIsVisible,
                controller: notifier.passwordController,
                hintText: context.localizations.password,
                errorText: context.localizations.passwordError(
                  watcher.passwordError ?? "",
                ),
                inputType: TextInputType.visiblePassword,
                suffix: IconButton(
                  onPressed: () => notifier.changePasswordVisibility(),
                  icon: Icon(
                    watcher.passwordIsVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                onChanged: (String newValue) {
                  notifier.changeValidPasswordState(newValue);
                },
              ),
              const SizedBox(height: 40.0),
              ActionButton(
                buttonWidth: double.infinity,
                onAction: () {
                  notifier.signup(context);
                },
                text: context.localizations.signUp.toUpperCase(),
              ),
              const SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.localizations.alreadyHaveAccount,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 8.0),
                  InkWell(
                    onTap: () => Sailor.back(),
                    child: Text(
                      context.localizations.login.toUpperCase(),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
