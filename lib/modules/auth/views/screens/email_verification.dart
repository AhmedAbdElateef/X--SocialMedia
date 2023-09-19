import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------
import 'package:social_x/core/ui/components/input/x_text_field.dart';
import 'package:social_x/core/ui/components/buttons/action_button.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
import 'package:social_x/core/ui/components/loaders/loading_overlay.dart';
//----------------------------------------------------------------
import 'package:social_x/modules/auth/views/widgets/auth_body.dart';
import 'package:social_x/modules/auth/view_models/reset_password_notifier.dart';
//------------------------------------------------------------------------------

class ResetPasswordScreen extends ConsumerWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(resetPasswordProvider);
    final watcher = ref.watch(resetPasswordProvider);
    return LoadingOverlay(
      loading: watcher.isLoading,
      child: Scaffold(
        body: AuthBody(
          children: [
            const SizedBox(height: 24.0),
            Text(
              context.localizations.typeYourEmail.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 14.0),
            Container(
              padding: const EdgeInsets.all(16),
              height: 86,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  context.localizations.resetPasswordMessageAlert,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 17),
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            XTextField(
              controller: notifier.emailController,
              hintText: context.localizations.email,
              inputType: TextInputType.emailAddress,
              errorText: context.localizations.emailError(
                watcher.error ?? "",
              ),
              onChanged: (String newValue) {
                notifier.changeValidEmailState(newValue);
              },
            ),
            const SizedBox(height: 40.0),
            ActionButton(
              buttonWidth: double.infinity,
              onAction: () {
                notifier.rqusetPasswordReset(context);
              },
              text: context.localizations.send.toUpperCase(),
            ),
            const SizedBox(height: 40.0),
            Image.asset(
              "assets/images/under_screen_auth.png",
              height: 64,
            )
          ],
        ),
      ),
    );
  }
}
