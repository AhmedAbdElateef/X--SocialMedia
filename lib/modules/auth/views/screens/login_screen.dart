import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------
import 'package:social_x/core/ui/routes.dart';
import 'package:social_x/core/helpers/extensions/sailor.dart';
import 'package:social_x/core/ui/components/input/x_text_field.dart';
import 'package:social_x/core/ui/components/buttons/action_button.dart';
import 'package:social_x/core/ui/components/buttons/social_button.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
import 'package:social_x/core/ui/components/loaders/loading_overlay.dart';
//----------------------------------------------------------------
import 'package:social_x/modules/auth/views/widgets/auth_body.dart';
import 'package:social_x/modules/auth/view_models//login_notifier.dart';
import 'package:social_x/modules/auth/services/login_methods/abstract.dart';
//--------------------------------------------------------------------------

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(loginProvider);
    final watcher = ref.watch(loginProvider);
    return LoadingOverlay(
      loading: watcher.isLoading,
      child: Scaffold(
        body: AuthBody(
          children: [
            const SizedBox(height: 20.0),
            Text(
              context.localizations.login.toUpperCase(),
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              context.localizations.loginSlogan,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 33.0),
            XTextField(
              controller: notifier.emailController,
              inputType: TextInputType.emailAddress,
              hintText: context.localizations.email,
              errorText: context.localizations.emailError(
                watcher.emailError ?? "",
              ),
              onChanged: (String newValue) {
                notifier.changeValidEmailState(newValue);
              },
            ),
            const SizedBox(height: 24.0),
            XTextField(
              secret: !watcher.passwordIsVisible,
              controller: notifier.passwordController,
              inputType: TextInputType.visiblePassword,
              hintText: context.localizations.password,
              errorText: context.localizations.passwordError(
                watcher.passwordError ?? "",
              ),
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
            InkWell(
              onTap: () => Sailor.toNamed(AppRoutes.resetPassword),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  context.localizations.forgotPassword.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 14,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            ActionButton(
              buttonWidth: double.infinity,
              onAction: () {
                notifier.login(
                  context: context,
                  method: EmailLogin(
                    userEmail: notifier.email,
                    userPassword: notifier.password,
                  ),
                );
              },
              text: context.localizations.login.toUpperCase(),
            ),
            const SizedBox(height: 40.0),
            Text(
              context.localizations.orLogInBy.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black.withOpacity(0.5),
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialButton(
                  iconName: "google",
                  onPressed: () {
                    notifier.login(
                      context: context,
                      method: GoogleLogin(),
                    );
                  },
                ),
                SocialButton(
                  iconName: "facebook",
                  onPressed: () {
                    notifier.login(
                      context: context,
                      method: FacebookLogin(),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.localizations.dontHaveAccount,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 8.0),
                InkWell(
                  onTap: () => Sailor.toNamed(AppRoutes.signup),
                  child: Text(
                    context.localizations.signUp.toUpperCase(),
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
    );
  }
}
