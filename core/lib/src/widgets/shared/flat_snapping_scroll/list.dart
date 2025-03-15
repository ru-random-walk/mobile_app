import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';

import 'controller.dart';
import 'physics.dart';

class FlatSnappingList extends StatefulWidget {
  final List<String> values;
  final double listWidth;
  final double itemHeight;
  final ValueChanged<int>? onIndexChanged;
  final FlatSnappingListController? controller;

  const FlatSnappingList({
    super.key,
    this.controller,
    required this.values,
    required this.itemHeight,
    required this.listWidth,
    this.onIndexChanged,
  });

  @override
  State<FlatSnappingList> createState() => _FlatSnappingListState();
}

class _FlatSnappingListState extends State<FlatSnappingList> {
  late final ValueNotifier<int> _changedSelectedIndex;

  @override
  void initState() {
    super.initState();
    final startOffset = widget.controller?.initialScrollOffset ?? 0;
    final initialIndex = startOffset ~/ widget.itemHeight;
    _changedSelectedIndex = ValueNotifier<int>(initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    final listPadding = (128 / 2 - widget.itemHeight / 2).toFigmaSize;

    return SizedBox(
      width: widget.listWidth,
      height: 128.toFigmaSize,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            final pixels = notification.metrics.pixels;
            if (pixels < 0 || pixels > notification.metrics.maxScrollExtent) {
              return false;
            }
            final newIndex = (pixels / widget.itemHeight).round();
            if (newIndex != _changedSelectedIndex.value) {
              _changedSelectedIndex.value = newIndex;
              widget.onIndexChanged?.call(newIndex);
            }
          }
          return true;
        },
        child: ListView.builder(
          controller: widget.controller,
          padding: EdgeInsets.symmetric(vertical: listPadding),
          itemExtent: widget.itemHeight,
          physics: ItemScrollPhysics(itemHeight: widget.itemHeight),
          itemBuilder: (_, index) => SizedBox(
            height: widget.itemHeight,
            child: ValueListenableBuilder<int>(
              valueListenable: _changedSelectedIndex,
              builder: (context, selectedIndex, child) {
                final isSelected = index == selectedIndex;
                final textTheme = context.textTheme;
                final style = isSelected
                    ? textTheme.bodyMRegularBase90
                    : textTheme.bodyMRegularBase70.copyWith(
                        color: context.colors.base_50.withOpacity(0.5),
                      );
                final value = widget.values[index];
                return Center(
                  child: Text(
                    value,
                    style: style,
                  ),
                );
              },
            ),
          ),
          itemCount: widget.values.length,
        ),
      ),
    );
  }
}
