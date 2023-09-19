import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:social_x/core/constants/html.dart';
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
import 'package:social_x/core/ui/components/layouts/screen_header.dart';
import 'package:social_x/core/ui/styles.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const ScreenHeader(title: ""),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppStyles.screensHorizontalPadding,
          ),
          physics: const BouncingScrollPhysics(),
          child: Html(
            data: context.langCode == "ar" ? privacyPolicyAr : privacyPolicyEn,
            style: {
              "p": Style(
                fontSize: FontSize(16.0),
                fontWeight: FontWeight.w500,
              ),
              "li": Style(fontWeight: FontWeight.w500),
            },
          ),
        ),
      ),
    );
  }
}
