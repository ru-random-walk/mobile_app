part of '../limited_wrap.dart';

/// Кастомный [MultiChildRenderObjectWidget] для создания
/// [Wrap] с ограниченным количеством строк
///
class LimitedWrap extends MultiChildRenderObjectWidget {
  /// Максимальное кол-во строк
  final int? maxLines;

  /// Расстояние между элементами в строке
  final double spacing;

  /// Расстояние между строками
  final double runSpacing;

  /// Дети
  // ignore: overridden_fields, annotate_overrides
  final List<Widget> children;

  /// Виджет, который будет отображаться при оверфлоу
  final Widget? overflowWidget;

  /// Функция, котрая будет вызвана, когда станет
  /// известно кол-во не уместившихся элементов
  ///
  final void Function(int amountOfOverflowedWidgets)? onWidgetsLayouted;

  /// Флаг, определяющий добавлен ли оверфлоу виджет
  final bool isOverflowedWidgetAdded;

  LimitedWrap({
    super.key,
    required this.children,
    this.maxLines,
    this.spacing = 0,
    this.runSpacing = 0,
    this.overflowWidget,
    this.onWidgetsLayouted,
    required this.isOverflowedWidgetAdded,
  }) : super(
          children: [
            ...children,
            if (overflowWidget != null) overflowWidget,
          ],
        );

  /// Создание кастомного [RenderObject]
  @override
  RenderObject createRenderObject(BuildContext context) {
    return _ExtendedRenderWrap(
      runSpacing: runSpacing,
      spacing: spacing,
      maxLines: maxLines,
      onWidgetsLayouted: onWidgetsLayouted,
      isOverflowWidgetAdded: isOverflowedWidgetAdded,
    );
  }

  /// Обновление кастомного [RenderObject]
  @override
  void updateRenderObject(
    BuildContext context,
    // ignore: library_private_types_in_public_api
    covariant _ExtendedRenderWrap renderObject,
  ) {
    renderObject
      ..onWidgetsLayouted = onWidgetsLayouted
      ..maxLines = maxLines;
    renderObject.onUpdate();
  }
}
