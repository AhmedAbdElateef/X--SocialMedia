import 'package:flutter/material.dart';
//-------------------------------------
import 'package:social_x/core/ui/colors.dart';
//--------------------------------------------

class TextMessageWidget extends StatelessWidget {
  final bool selfMessage;
  final String text;

  const TextMessageWidget({
    super.key,
    required this.selfMessage,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: selfMessage ? Colors.white : Theme.of(context).primaryColor,
        border: selfMessage
            ? Border.all(
                color: AppColors.grey10,
                width: 2.0,
              )
            : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: selfMessage
              ? Theme.of(context).colorScheme.secondary
              : Colors.white,
        ),
      ),
    );
  }
}
