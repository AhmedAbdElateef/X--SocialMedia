import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_x/core/constants/errors.dart';
import 'package:social_x/core/constants/hive_boxes.dart';
import 'package:social_x/core/models/http_client_result.dart';
import 'package:social_x/core/ui/components/layouts/home_wrapper.dart';
import 'package:social_x/core/ui/components/loaders/loading_popup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
import 'package:social_x/core/helpers/extensions/sailor.dart';
import 'package:social_x/core/helpers/functions/clients_error_handler.dart';
import 'package:social_x/core/ui/routes.dart';
import 'package:social_x/modules/auth/helpers/email_validator.dart';
import 'package:social_x/modules/auth/helpers/password_validator.dart';
import 'package:social_x/modules/auth/helpers/username_validator.dart';
import 'package:social_x/modules/auth/models/user.dart';
import 'package:social_x/modules/profile/services/profile_edit_client.dart';
import 'package:social_x/modules/profile/services/user_image_client.dart';
//------------------------------------------------------

final profileFormProvider = ChangeNotifierProvider.autoDispose((_) {
  return ProfileFormNotifier();
});

class ProfileFormNotifier extends ChangeNotifier {
  bool isLoading = false;

  String? newImageUrl;
  String? emailError = "init";
  String? passwordError = "init";
  String? usernameError = "init";

  final _cachedData = HiveBoxes.prefsBox;

  ProfileFormNotifier() {
    SocialXUser oldUserData = _cachedData.get(HiveBoxes.userCredentialsKey);
    bioController.text = oldUserData.bio ?? "";
    addressController.text = oldUserData.address ?? "";
    userNameController.text = oldUserData.name ?? "";
    emailController.text = oldUserData.email ?? "";
    phoneNumberController.text = oldUserData.phoneNumber ?? "";
    facebookUrlController.text = oldUserData.facebookLink ?? "";
    personalWebsiteController.text = oldUserData.personalWebsiteLink ?? "";
    instagramController.text = oldUserData.instagramLink ?? "";
    newImageUrl = oldUserData.imageUrl;
  }

  final _profileEditClient = ProfileEditClient();
  final _userImagesClient = UserImagesClient();

  final bioController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final facebookUrlController = TextEditingController();
  final personalWebsiteController = TextEditingController();
  final instagramController = TextEditingController();
  final passwordController = TextEditingController();

  bool get validInput {
    // update error states
    changeValidEmailState(emailController.text);
    changeValidPasswordState(passwordController.text);
    changeValidUsernameState(userNameController.text);

    return emailError == null && passwordError == null && usernameError == null;
  }

  Future<void> updateUserProfile(BuildContext context) async {
    if (!validInput) {
      handleHttpClientError(context, AppErrors.invalidInput);
      return;
    }

    final newUserData = SocialXUser.fromJson({
      "bio": bioController.text,
      "email": emailController.text,
      "user_name": userNameController.text,
      "address": addressController.text,
      "image_url": newImageUrl,
      "phone_number": phoneNumberController.text,
      "facebook_link": facebookUrlController.text,
      "instagram_link": instagramController.text,
      "personal_website_link": personalWebsiteController.text,
    });

    final result = await _profileEditClient.editProfile(newUserData);

    if (result is SuccessfulRequest) {
      Sailor.startOverFromRoute(AppRoutes.home);
      pageController.jumpToPage(0);
      _cachedData.put(HiveBoxes.userCredentialsKey, newUserData);

      // ignore: use_build_context_synchronously
      Fluttertoast.showToast(msg: context.localizations.profileUpdated);
    } else if (result is FailedRequest) {
      // ignore: use_build_context_synchronously
      handleHttpClientError(context, result.errorCode);
    }

    _changeLoadingState(false);
  }

  Future<void> addUserImage(BuildContext context) async {
    showLoadingPopup(
      description: context.localizations.uploading,
      context: context,
    );
    final result = await _userImagesClient.pickAndUploadImage();
    Sailor.back();

    if (result is SuccessfulRequest) {
      final mediaUrl = result.retrievedData["media_url"];
      newImageUrl = mediaUrl;
      notifyListeners();
    } else if (result is FailedRequest) {
      // ignore: use_build_context_synchronously
      handleHttpClientError(context, result.errorCode);
    }
  }

  void changeValidEmailState(String newValue) {
    final emailValidation = EmailValidator.dirty(newValue);
    final newState = emailValidation.error;
    emailError = newState;
    notifyListeners();
  }

  void changeValidPasswordState(String newValue) {
    if (newValue.isEmpty) {
      passwordError = null;
      notifyListeners();
      return;
    }

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

  void _changeLoadingState(bool newLoadingState) {
    isLoading = newLoadingState;
    notifyListeners();
  }

  @override
  void dispose() {
    bioController.dispose();
    userNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    facebookUrlController.dispose();
    personalWebsiteController.dispose();
    instagramController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
