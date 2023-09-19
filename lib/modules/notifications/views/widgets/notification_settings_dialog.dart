import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_x/core/helpers/extensions/themes_helper.dart';
//--------------------------------------
import 'package:social_x/core/ui/styles.dart';
import 'package:social_x/core/ui/colors.dart';
import 'package:social_x/core/helpers/extensions/sailor.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
//--------------------------------------------------------------
import 'package:social_x/modules/notifications/views/widgets/notification_switch.dart';
//-------------------------------------------------------------------------------------

void showNotificationSettingsDialog(BuildContext context) {
  showCupertinoModalPopup(
    context: context,
    builder: (ctx) {
      return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 2,
        child: Scaffold(
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 30.0,
                  horizontal: AppStyles.screensHorizontalPadding,
                ),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        context.localizations.settings,
                        style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w700,
                          fontFamily: "ProximaNova",
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    NotificationSwitch(context.localizations.commentLikes),
                    const SizedBox(height: 16.0),
                    NotificationSwitch(context.localizations.followers),
                    const SizedBox(height: 16.0),
                    NotificationSwitch(context.localizations.likes),
                    const SizedBox(height: 30.0)
                  ],
                ),
              ),
              Align(
                alignment: const Alignment(0.0, -1),
                child: Container(
                  width: double.infinity,
                  height: 10,
                  color: AppColors.grey55,
                ),
              ),
              Align(
                alignment: const Alignment(0.0, -1.085),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => Sailor.back(),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.grey55,
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.close_rounded,
                        size: 25.0,
                        color: context.darkMoodEnabled
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
