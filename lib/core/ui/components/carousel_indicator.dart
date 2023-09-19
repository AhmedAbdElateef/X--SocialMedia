import 'package:flutter/material.dart';
//-------------------------------------

class PaginationIndex extends StatelessWidget {
  final int numberOfItems;
  final int activeIndex;

  const PaginationIndex({
    super.key,
    required this.numberOfItems,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        numberOfItems,
        (i) => Dot(active: i == activeIndex),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final bool active;

  const Dot({super.key, required this.active});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          color: active
              ? Theme.of(context).primaryColor
              : Theme.of(context).colorScheme.secondary,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
