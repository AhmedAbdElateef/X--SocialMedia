import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//--------------------------------------------

class ActionButton extends StatelessWidget {
  /// determines if the button width should match [text] width.
  final bool wrapParent;
  final bool activeIcon;

  final double? elevation;
  final double buttonHeight;
  final double buttonWidth;
  final double? borderRadius;

  final String? text;
  final String? iconName;

  final Color textColor;
  final Color? buttonColor;
  final Color? overlayColor;

  final VoidCallback? onAction;

  const ActionButton({
    super.key,
    this.wrapParent = false,
    this.activeIcon = false,
    this.elevation,
    this.buttonHeight = 50.0,
    this.buttonWidth = 150.0,
    this.borderRadius,
    this.iconName,
     this.text,
    this.textColor = Colors.white,
    this.buttonColor,
    this.overlayColor,
    required this.onAction,
  });

  Text get textWidget {
    return Text(
      text!,
      style: TextStyle(
        height: 1,
        fontSize: 16.0,
        color: textColor,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight,
      width: wrapParent ? null : buttonWidth,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            buttonColor ?? Theme.of(context).primaryColor,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
            ),
          ),
          elevation: MaterialStateProperty.all(elevation ?? 2.0),
          overlayColor: MaterialStateProperty.all(
            overlayColor ?? Theme.of(context).colorScheme.secondary,
          ),
        ),
        onPressed: onAction,
        child: iconName != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textWidget,
                  const SizedBox(width: 16.0),
                  SvgPicture.asset(
                    activeIcon
                        ? "assets/icons/${iconName}_active.svg"
                        : "assets/icons/$iconName.svg",
                    height: 20.0,
                    width: 20.0,
                    colorFilter: ColorFilter.mode(
                      activeIcon ? Colors.red : Theme.of(context).primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              )
            : textWidget,
      ),
    );
  }
}
