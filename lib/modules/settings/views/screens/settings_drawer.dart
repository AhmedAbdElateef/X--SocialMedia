import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------
import 'package:social_x/core/ui/colors.dart';
import 'package:social_x/core/ui/routes.dart';
import 'package:social_x/core/constants/hive_boxes.dart';
import 'package:social_x/core/helpers/extensions/sailor.dart';
import 'package:social_x/core/helpers/extensions/themes_helper.dart';
import 'package:social_x/core/ui/components/images/cached_network_image.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
//-------------------------------------------------------------------------
import 'package:social_x/modules/auth/models/user.dart';
import 'package:social_x/modules/settings/view_models/settings_notifier.dart';
import 'package:social_x/modules/settings/views/widgets/lang_change_dialog.dart';
import 'package:social_x/modules/settings/views/widgets/theme_change_dialog.dart';
import 'package:social_x/modules/settings/views/widgets/drawer_action_button.dart';
//---------------------------------------------------------------------------------

class SettingDrawer extends ConsumerWidget {
  const SettingDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var notifier = ref.read(settingsProvider);
    final cachedData = HiveBoxes.prefsBox;
    SocialXUser userData = cachedData.get(HiveBoxes.userCredentialsKey);
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(context.isRTL ? 0 : 20),
          bottomRight: Radius.circular(context.isRTL ? 0 : 20),
          topLeft: Radius.circular(context.isRTL ? 20 : 0),
          bottomLeft: Radius.circular(context.isRTL ? 20 : 0),
        ),
      ),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 163.0,
            child: Stack(
              children: [
                Container(
                  height: 128.0,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: context.darkMoodEnabled
                        ? AppColors.grey85
                        : AppColors.grey40,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(context.isRTL ? 0 : 20),
                      bottomRight: Radius.circular(context.isRTL ? 0 : 20),
                      topLeft: Radius.circular(context.isRTL ? 20 : 0),
                      bottomLeft: Radius.circular(context.isRTL ? 20 : 0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        userData.name.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: context.darkMoodEnabled
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        userData.email.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          color: context.darkMoodEnabled
                              ? Colors.white
                              : Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned.directional(
                  textDirection: context.textDirection,
                  top: 82.5,
                  start: 10.0,
                  child: ClipOval(
                    child: getCachedImage(
                      userData.imageUrl.toString(),
                      height: 81.5,
                      width: 81.5,
                      fallbackImageName: "default.png",
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40.0),
          DrawerActionButton(
            title: context.localizations.savedPosts,
            iconAssetName: "save.svg",
            onAction: () {
              Sailor.toNamed(AppRoutes.savedPosts);
            },
          ),
          const SizedBox(height: 12.0),
          DrawerActionButton(
            title: context.localizations.appLanguage,
            iconAssetName: "conversation.svg",
            onAction: () {
              showLangChangeDialog(context);
            },
          ),
          const SizedBox(height: 12.0),
          DrawerActionButton(
            title: context.localizations.appTheme,
            iconAssetName: "theme.svg",
            onAction: () {
              showThemeChangeDialog(context);
            },
          ),
          const SizedBox(height: 12.0),
          DrawerActionButton(
            title: context.localizations.appShare,
            iconAssetName: "shared.svg",
            onAction: () {
              notifier.shareApp();
            },
          ),
          const SizedBox(height: 12.0),
          DrawerActionButton(
            title: context.localizations.privacyPolicy,
            iconAssetName: "book.svg",
            onAction: () {
              Sailor.toNamed(AppRoutes.settingsPrivacyPolicy);
            },
          ),
          const SizedBox(height: 12.0),
          DrawerActionButton(
            title: context.localizations.logout,
            iconAssetName: "exit.svg",
            onAction: () {
              notifier.logout();
            },
          ),
        ],
      ),
    );
  }
}
