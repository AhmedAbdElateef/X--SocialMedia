import 'package:flutter/material.dart';
//-------------------------------------
import 'package:social_x/core/ui/components/loaders/circular_loading_indicator.dart';
//---------------------------------------------------------------------------

class LoadingOverlay extends StatelessWidget {
  /// determines whether to show this loading overlay or not.
  final bool loading;

  final Color? barrierColor;

  final Widget child;

  const LoadingOverlay({
    super.key,
    required this.loading,
    this.barrierColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!loading) return child;

    return AbsorbPointer(
      absorbing: true,
      child: Stack(
        children: [
          child,
          ModalBarrier(
            dismissible: false,
            color: barrierColor ??
                Theme.of(context).colorScheme.secondary.withOpacity(0.25),
          ),
          const CircularLoadingIndicator(),
        ],
      ),
    );
  }
}
