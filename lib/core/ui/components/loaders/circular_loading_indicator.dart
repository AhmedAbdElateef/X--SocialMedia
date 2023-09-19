import 'package:flutter/material.dart';
//-------------------------------------

class CircularLoadingIndicator extends StatelessWidget {
  final bool centerWidget;

  final double? size;
  final double? loadingValue;

  final Color? loadingColor;

  const CircularLoadingIndicator({
    super.key,
    this.centerWidget = true,
    this.size = 35.0,
    this.loadingValue,
    this.loadingColor,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          strokeWidth: 3.5,
          value: loadingValue,
          color: loadingColor ?? Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
