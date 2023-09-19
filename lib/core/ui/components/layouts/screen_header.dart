import 'package:flutter/material.dart';
//-------------------------------------
import 'package:social_x/core/ui/colors.dart';
import 'package:social_x/core/helpers/extensions/sailor.dart';
import 'package:social_x/core/helpers/extensions/themes_helper.dart';
//-------------------------------------------------------------------

class ScreenHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool transparent;
  final Color? textColor;
  final Color? arrowColor;

  final Widget? trailing;

  const ScreenHeader({
    super.key,
    required this.title,
    this.transparent = false,
    this.textColor,
    this.arrowColor,
    this.trailing,
  });

  @override
  Size get preferredSize {
    return const Size.fromHeight(65);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height,
      width: preferredSize.width,
      child: AppBar(
        backgroundColor: transparent ? Colors.transparent : null,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            height: 1.0,
            fontSize: 20.0,
            color: textColor ??
                (context.darkMoodEnabled
                    ? Colors.white
                    : AppColors.onPrimaryColor),
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            size: 24.0,
            color: arrowColor,
          ),
          onPressed: () => Sailor.back(),
        ),
        actions: trailing != null ? [trailing!] : null,
      ),
    );
  }
}
