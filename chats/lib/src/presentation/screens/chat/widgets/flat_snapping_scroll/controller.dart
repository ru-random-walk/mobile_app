import 'package:flutter/material.dart';

class FlatSnappingListController extends ScrollController {
  final double itemExtent;

  FlatSnappingListController({
    int initialIndex = 0,
    super.keepScrollOffset,
    super.debugLabel,
    super.onAttach,
    super.onDetach,
    required this.itemExtent,
  }) : super(initialScrollOffset: itemExtent * initialIndex);

  Future<void> animateToIndex(int index) {
    return animateTo(
      index * itemExtent,
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
    );
  }
}
