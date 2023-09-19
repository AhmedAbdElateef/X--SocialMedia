import 'package:flutter/material.dart';
//-------------------------------------
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_x/core/helpers/extensions/themes_helper.dart';
import 'package:social_x/core/ui/styles.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
//--------------------------------------------------------------
import 'package:social_x/modules/notifications/views/widgets/notification_item.dart';
import 'package:social_x/modules/notifications/views/widgets/notification_settings_dialog.dart';
//----------------------------------------------------------------------------------------------

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppStyles.screensHorizontalPadding,
      ),
      child: Column(
        children: [
          const SizedBox(height: 20.0),
          Row(
            children: [
              Text(
                context.localizations.notifications,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "(05)",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => showNotificationSettingsDialog(context),
                icon: SvgPicture.asset(
                  "assets/icons/setting.svg",
                  width: 25,
                  height: 25,
                  colorFilter: ColorFilter.mode(
                    context.darkMoodEnabled ? Colors.white : Colors.black,
                    BlendMode.srcIn,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, index) {
                if (index == 19) return const SizedBox(height: 30.0);

                return const NotificationItem();
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16.0);
              },
              itemCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}
