import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
import 'package:social_x/core/ui/components/buttons/action_button.dart';
import 'package:social_x/core/ui/components/images/cached_network_image.dart';
//-------------------------------------
import 'package:social_x/core/ui/components/layouts/screen_header.dart';
import 'package:social_x/core/ui/components/input/x_text_field.dart';
import 'package:social_x/core/ui/components/loaders/loading_overlay.dart';
import 'package:social_x/core/ui/styles.dart';
import 'package:social_x/modules/profile/view_models/profile_form_notifier.dart';
//--------------------------------------------------------------

class ProfileEditScreen extends ConsumerWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var notifier = ref.read(profileFormProvider);
    var watcher = ref.watch(profileFormProvider);
    return SafeArea(
      child: LoadingOverlay(
        loading: watcher.isLoading,
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/profile_edit_background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppStyles.screensHorizontalPadding,
              ),
              child: Column(
                children: [
                  ScreenHeader(
                    transparent: true,
                    title: context.localizations.editProfile,
                    textColor: Colors.white,
                    arrowColor: Colors.white,
                  ),
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        const SizedBox(height: 20),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipOval(
                              child: getCachedImage(
                                watcher.newImageUrl.toString(),
                                height: 120,
                                width: 120,
                                fallbackImageName: "default.png",
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: MediaQuery.of(context).size.width / 2 - 75,
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.white.withOpacity(0.3),
                                child: InkWell(
                                  onTap: () => notifier.addUserImage(context),
                                  child: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 60),
                        XTextField(
                          borderRadius: 12,
                          fillColor: Colors.white.withOpacity(0.2),
                          textColor: Colors.white,
                          hintText: context.localizations.bio,
                          controller: notifier.bioController,
                          prefix: const Icon(
                            Icons.edit_square,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(height: 30),
                        XTextField(
                          borderRadius: 12,
                          fillColor: Colors.white.withOpacity(0.2),
                          textColor: Colors.white,
                          hintText: context.localizations.userName,
                          controller: notifier.userNameController,
                          errorText: context.localizations.usernameError(
                            watcher.usernameError ?? "",
                          ),
                          onChanged: (String newValue) {
                            notifier.changeValidUsernameState(newValue);
                          },
                          prefix: const Icon(
                            Icons.person_2,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(height: 30),
                        XTextField(
                          borderRadius: 12,
                          fillColor: Colors.white.withOpacity(0.2),
                          textColor: Colors.white,
                          hintText: context.localizations.address,
                          controller: notifier.addressController,
                          prefix: const Icon(
                            Icons.edit_location_outlined,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(height: 30),
                        XTextField(
                          borderRadius: 12,
                          fillColor: Colors.white.withOpacity(0.2),
                          textColor: Colors.white,
                          hintText: context.localizations.email,
                          inputType: TextInputType.emailAddress,
                          controller: notifier.emailController,
                          errorText: context.localizations.emailError(
                            watcher.emailError ?? "",
                          ),
                          onChanged: (String newValue) {
                            notifier.changeValidEmailState(newValue);
                          },
                          prefix: const Icon(
                            Icons.alternate_email_outlined,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(height: 30),
                        XTextField(
                          borderRadius: 12,
                          fillColor: Colors.white.withOpacity(0.2),
                          textColor: Colors.white,
                          inputType: TextInputType.phone,
                          hintText: context.localizations.phoneNumber,
                          controller: notifier.phoneNumberController,
                          prefix: const Icon(
                            Icons.phone,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(height: 30),
                        XTextField(
                          borderRadius: 12,
                          fillColor: Colors.white.withOpacity(0.2),
                          textColor: Colors.white,
                          hintText: context.localizations.facebook,
                          controller: notifier.facebookUrlController,
                          prefix: const Icon(
                            Icons.facebook_outlined,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(height: 30),
                        XTextField(
                          borderRadius: 12,
                          fillColor: Colors.white.withOpacity(0.2),
                          textColor: Colors.white,
                          hintText: context.localizations.personalWebsite,
                          controller: notifier.personalWebsiteController,
                          prefix: const Icon(
                            Icons.public,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(height: 30),
                        XTextField(
                          borderRadius: 12,
                          fillColor: Colors.white.withOpacity(0.2),
                          textColor: Colors.white,
                          hintText: context.localizations.instagram,
                          controller: notifier.instagramController,
                          prefix: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: SvgPicture.asset(
                              "assets/icons/instagram.svg",
                              height: 25,
                              width: 25,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        XTextField(
                          borderRadius: 12,
                          fillColor: Colors.white.withOpacity(0.2),
                          textColor: Colors.white,
                          hintText: context.localizations.password,
                          controller: notifier.passwordController,
                          inputType: TextInputType.visiblePassword,
                          errorText: context.localizations.passwordError(
                            watcher.passwordError ?? "",
                          ),
                          onChanged: (String newValue) {
                            notifier.changeValidPasswordState(newValue);
                          },
                          prefix: const Icon(
                            Icons.lock,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(height: 50),
                        ActionButton(
                          text: context.localizations.saveChanges,
                          buttonColor:
                              Theme.of(context).primaryColor.withOpacity(0.3),
                          onAction: () {
                            notifier.updateUserProfile(context);
                          },
                        ),
                        AppStyles.screenBottomSpace,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
