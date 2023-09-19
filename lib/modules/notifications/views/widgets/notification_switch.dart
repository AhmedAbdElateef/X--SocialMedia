import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_x/core/helpers/extensions/themes_helper.dart';
//--------------------------------------
import 'package:social_x/core/ui/colors.dart';
//--------------------------------------------

class NotificationSwitch extends StatelessWidget {
  final String optionText;

  const NotificationSwitch(
    this.optionText, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.darkMoodEnabled ? AppColors.bgBlack : AppColors.grey25,
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 14.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            optionText,
            style: const TextStyle(fontSize: 17.0),
          ),
          CupertinoSwitch(
            value: false,
            activeColor: Theme.of(context).primaryColor,
            thumbColor: Colors.white,
            onChanged: (_) {},
          ),
        ],
      ),
    );
  }
}
