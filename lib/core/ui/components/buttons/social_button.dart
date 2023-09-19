import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//--------------------------------------------

class SocialButton extends StatelessWidget {
  final bool showElevation;

  final String iconName;

  final VoidCallback? onPressed;

  const SocialButton({
    super.key,
    this.showElevation = false,
    required this.iconName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          CircleBorder(
            side: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2.0,
            ),
          ),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(10.0),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        elevation: MaterialStateProperty.all(showElevation ? 5.0 : 0.0),
        shadowColor: MaterialStateProperty.all(Colors.white),
        overlayColor: MaterialStateProperty.all(
          Theme.of(context).colorScheme.secondary.withOpacity(0.25),
        ),
      ),
      onPressed: onPressed,
      child: SvgPicture.asset(
        "assets/icons/$iconName.svg",
        height: 24.0,
        width: 24.0,
        colorFilter: ColorFilter.mode(
          Theme.of(context).primaryColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
