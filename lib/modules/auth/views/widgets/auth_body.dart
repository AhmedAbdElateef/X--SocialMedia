import 'package:flutter/material.dart';
import 'package:social_x/core/helpers/extensions/themes_helper.dart';
//-------------------------------------
import 'package:social_x/core/ui/styles.dart';
//--------------------------------------------

class AuthBody extends StatelessWidget {
  final List<Widget> children;

  const AuthBody({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final deviceScreenHeight = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          "assets/images/auth_header.jpg",
          height: deviceScreenHeight / 3.5,
          width: double.infinity,
          alignment: Alignment.topCenter,
          fit: BoxFit.fitWidth,
        ),
        Positioned.fill(
          top: deviceScreenHeight / 3.5 - 28,
          child: Card(
            elevation: 0.0,
            color: context.darkMoodEnabled ? Colors.black : Colors.white,
            margin: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(28.0),
                topLeft: Radius.circular(28.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
              ),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  ...children,
                  AppStyles.screenBottomSpace,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
