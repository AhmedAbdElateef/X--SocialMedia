import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_x/core/helpers/extensions/sailor.dart';
//-----------------------------------------------------------
import 'package:social_x/core/ui/colors.dart';
import 'package:social_x/core/ui/styles.dart';
import 'package:social_x/core/helpers/extensions/themes_helper.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
import 'package:social_x/modules/settings/view_models/settings_notifier.dart';
//-------------------------------------------------------------------------

void showThemeChangeDialog(BuildContext context) {
  showCupertinoModalPopup(
    context: context,
    builder: (context) {
      return SizedBox(
        width: double.infinity,
        height: 230,
        child: Scaffold(
          body: CupertinoListSection(
            decoration: BoxDecoration(
              color: context.darkMoodEnabled ? Colors.black : Colors.white,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: AppStyles.screensHorizontalPadding,
              vertical: 16.0,
            ),
            header: Center(
              child: Text(
                context.localizations.appTheme,
                style: const TextStyle(
                  height: 1.0,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: "ProximaNova",
                ),
              ),
            ),
            footer: const SizedBox(height: 19.0),
            children: List.generate(2, (index) {
              return CupertinoListTile(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 10.0,
                ),
                title: Text(
                  context.localizations.theme(index.toString()),
                  style: TextStyle(
                    height: 1.0,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color:
                        context.darkMoodEnabled ? Colors.white : Colors.black,
                  ),
                ),
                leading: Transform.scale(
                  scale: 1.5,
                  child: Consumer(
                    builder: (_, ref, __) {
                      var notifier = ref.read(settingsProvider);
                      var watcher = ref.watch(settingsProvider);
                      return CupertinoRadio<Brightness>(
                        activeColor: Theme.of(context).primaryColor,
                        inactiveColor: AppColors.grey25,
                        groupValue: watcher.appTheme.brightness,
                        value: index == 0 ? Brightness.dark : Brightness.light,
                        onChanged: (Brightness? newBrightness) {
                          Sailor.back();
                          notifier
                              .changeAppTheme(newBrightness == Brightness.dark);
                        },
                      );
                    },
                  ),
                ),
              );
            }),
          ),
        ),
      );
    },
  );
}
