import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
//------------------------------------------------------

class DrawerActionButton extends ConsumerWidget {
  final String title;
  final String iconAssetName;

  final VoidCallback onAction;

  const DrawerActionButton({
    super.key,
    required this.title,
    required this.iconAssetName,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.25)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 25.0),
          SvgPicture.asset(
            "assets/icons/$iconAssetName",
            width: 32.0,
          ),
          const SizedBox(width: 30.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              height: 1.0,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
      onPressed: () {
        Scaffold.of(context).closeDrawer();
        onAction();
      },
    );
  }
}
