import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
//----------------------------------------------
import 'package:social_x/core/helpers/extensions/localization_helper.dart';
//-------------------------------------------------------------------------

void handleHttpClientError(BuildContext context, String errorCode) {
  if (context.mounted) {
    Fluttertoast.showToast(
      msg: context.localizations.toastError(errorCode),
    );
  }
}
