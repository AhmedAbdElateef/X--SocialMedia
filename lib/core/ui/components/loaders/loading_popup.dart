import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_x/core/ui/colors.dart';

void showLoadingPopup({
  required String description,
  required BuildContext context,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (ctx) => WillPopScope(
      onWillPop: () => Future.value(false),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.5),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              description,
              style: const TextStyle(
                fontSize: 20.0,
                height: 1.0,
                color: AppColors.grey25,
              ),
            ),
            const SizedBox(height: 25.0),
            const CupertinoActivityIndicator(radius: 20.0),
          ],
        ),
      ),
    ),
  );
}
