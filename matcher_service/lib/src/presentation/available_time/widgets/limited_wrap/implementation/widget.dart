part of '../limited_wrap.dart';

/// Функция-билдер для оверфлоу виджета
///
typedef OnWidgetsLayouted = Widget Function(int? amountOfOverflowedWidgets);

/// Кастомный виджет [Wrap] с ограниченным количеством строк и
/// опциональным виджетом для отображения при переполнении
///
class LimitedWrapWidget extends StatelessWidget {
  /// Дети
  final List<Widget> children;

  /// Функция-билдер для оверфлоу виджета
  final OnWidgetsLayouted? overflowWidgetBuilder;

  /// Отступ между элементами в строке
  final double spacing;

  /// Отступ между строками
  final double runSpacing;

  /// Максимальное количество строк
  final int? maxLines;

  /// Нотифайер, который будет вызывать [overflowWidgetBuilder] при получении
  /// кол-ва неубравашихся элементов
  ///
  final amountOfOverflowedWidgetsNotifier = ValueNotifier<int?>(null);

  LimitedWrapWidget({
    super.key,
    this.overflowWidgetBuilder,
    required this.children,
    required this.spacing,
    required this.runSpacing,
    this.maxLines,
  });

  /// Оборачиваем [overflowWidgetBuilder] в [ValueListenableBuilder]
  /// чтобы перестраивать виджет когда станет известно новое значение
  /// кол-ва неубравашихся элементов
  ///
  /// Когда будет вызвана `onWidgetsLayouted` функция, то в нотифайер передастся
  /// новое значение `amountOfOverflowedWidgets` кол-ва
  /// неубравашихся элементов, что вызывет ребилд
  /// оверфлоу виджета
  ///
  @override
  Widget build(BuildContext context) {
    final overflowWidget = overflowWidgetBuilder != null
        ? ValueListenableBuilder<int?>(
            valueListenable: amountOfOverflowedWidgetsNotifier,
            builder: (context, value, child) => overflowWidgetBuilder!(value),
          )
        : null;

    final widgets = [
      ...children,
      if (overflowWidget != null) overflowWidget,
    ];

    return LimitedWrap(
      spacing: spacing,
      runSpacing: runSpacing,
      maxLines: maxLines,
      onWidgetsLayouted: (amountOfOverflowedWidgets) {
        amountOfOverflowedWidgetsNotifier.value = amountOfOverflowedWidgets;
      },
      isOverflowedWidgetAdded: overflowWidget != null,
      children: widgets,
    );
  }
}
