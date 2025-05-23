// ignore_for_file: lines_longer_than_80_chars, omit_local_variable_types, cast_nullable_to_non_nullable

part of '../limited_wrap.dart';

/// ParentData для [_ExtendedRenderWrap]
///
class LimitWrapParentData extends ContainerBoxParentData<RenderBox> {}

/// Кастомный [RenderBox] для создания [Wrap] с ограниченным количеством строк
/// и индикатором неубравшихся элементов
///
class _ExtendedRenderWrap extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, LimitWrapParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, LimitWrapParentData> {
  _ExtendedRenderWrap({
    List<RenderBox>? children,
    required this.runSpacing,
    required this.spacing,
    void Function(int)? onWidgetsLayouted,
    int? maxLines,
    required this.isOverflowWidgetAdded,
  })  : _onWidgetsLayouted = onWidgetsLayouted,
        _maxLines = maxLines {
    addAll(children);
  }

  /// Флаг - посчитан ли количество переполненных элементов
  bool calculatedOverflow = false;

  /// Флаг - показывать ли последний элемент, который смог убраться
  ///
  /// При багах необходимо будет заменить на кол-во
  ///
  bool isHideLastItemIfOverflowed = false;

  /// Нулевое ограничение для тех [RenderBox]'ов, которые мы не будем
  /// отображать на экране
  ///
  static const _shrinkedConstraints = BoxConstraints(maxWidth: 0, maxHeight: 0);

  /// Отступы между элементами в одной строке
  final double spacing;

  /// Отсутпы между строками элементов
  final double runSpacing;

  /// Максимальное количество строк
  int? _maxLines;

  /// Функция, которая будет вызвана в тот момент, когда мы
  /// узнаем кол-во неубравшихся элементов
  ///
  void Function(int amountOfOverflowedWidgets)? _onWidgetsLayouted;

  /// Флаг, который показывает, добавлен ли виджет, который
  /// необходимо отображать при переполнении
  ///
  final bool isOverflowWidgetAdded;

  /// Сеттер максимального количества строк
  ///
  /// При его обновлении сбрасывается флаг [calculatedOverflow]
  /// и вызывается перерисовка
  ///
  set maxLines(int? value) {
    if (_maxLines == value) return;
    _maxLines = value;
    calculatedOverflow = false;
    markNeedsLayout();
  }

  /// Сеттер для функции [onWidgetsLayouted]
  ///
  /// При его обновлении сбрасывается флаг [calculatedOverflow]
  /// и вызывается перерисовка
  ///
  set onWidgetsLayouted(void Function(int amountOfOverflowedWidgets)? fun) {
    _onWidgetsLayouted = fun;
    calculatedOverflow = false;
    markNeedsLayout();
  }

  /// Функция, которая вызываеся когда обновляется [RenderObject]
  ///
  /// Сбрасывается флаг [calculatedOverflow]
  /// и флаг [isHideLastItemIfOverflowed]
  ///
  void onUpdate() {
    isHideLastItemIfOverflowed = false;
    calculatedOverflow = false;
  }

  /// Установка parentData для [RenderBox]
  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! LimitWrapParentData) {
      child.parentData = LimitWrapParentData();
    }
  }

  /// Главная функция в которой находится вся логика построения элементов
  ///
  /// В ней мы будем отрисовывать всех детей
  ///
  @override
  void performLayout() {
    /// Количество неубравшихся элементов
    int objectsOverflowed = 0;

    /// Количество всех детей
    var allElements = childCount;

    /// Если был добавлен оверфлоу виджет, то уменьшаем счетчик всех детей на 1,
    /// так как он не будет учитываться в количестве виджетов для отрисовки
    ///
    if (isOverflowWidgetAdded) allElements -= 1;

    /// Получаем родительский констрейнты
    final constraints = this.constraints.copyWith(minWidth: 0, minHeight: 0);

    /// Получаем первый дочерний элемент
    RenderBox? child = firstChild;

    /// Если первый ребенок сразу null, то ничего
    /// не отрисываем и указываем минимальные ограничения
    ///
    if (child == null) {
      size = constraints.smallest;
      return;
    }

    /// Координаты смещения для отображения текущего элемента
    double dx = 0;
    double dy = 0;

    /// Максимальная высота элемента для текущей строки
    double maxYPerRow = 0;

    /// Количество отображенных строк
    int renderedRows = 1;

    /// Индекс текущего элемента
    int curIndex = 0;

    /// Начальные координаты предпоследнего отображенного
    /// дочернего элемента
    ///
    Offset? penultimateRenderedChildOffset;

    /// Предпоследний отображенный дочерний элемент
    RenderBox? penultimateRenderedChild;

    /// Последний отображенный дочерний элемент
    RenderBox? lastRenderedChild;

    /// Флаг, показывающий, что элементы переполнены
    bool hasOverflow = false;

    /// Функция для пропуска отрисовки дочернего элемента
    void passChild() {
      objectsOverflowed++;
      curIndex++;
      child?.layout(
        _shrinkedConstraints,
        parentUsesSize: true,
      );
      final LimitWrapParentData childParentData =
          child?.parentData as LimitWrapParentData;
      child = childParentData.nextSibling;
    }

    /// Цикл для перебора всех дочерних элементов и их отрисовки
    while (child != null && curIndex < allElements) {
      /// Если уже переполнено, то пропускаем дочерний элемент
      if (hasOverflow) {
        passChild();
        continue;
      }

      /// Лэйаутим дочерний элемент и получаем его размеры
      child!.layout(constraints, parentUsesSize: true);
      final childSize = child!.size;

      /// Если было передано ограничение максимального количества строк,
      /// то перед тем как идти дальше проверяем, хватит для него место
      ///
      /// Если места уже недостаточно, то поднимаем флаг что произошло
      /// переполнение и пропускаем дочерний элемент
      ///
      if (_maxLines != null) {
        if (renderedRows > _maxLines! ||
            renderedRows == _maxLines! &&
                dx + childSize.width + spacing > constraints.maxWidth) {
          hasOverflow = true;
          passChild();
          continue;
        }
      }

      /// Если элемент для отрисовки не убирается на данную строку, то
      /// переносим его на следующую и увеличиваем счетчик строк
      if (dx + childSize.width + spacing > constraints.maxWidth) {
        renderedRows++;
        dx = 0;
        dy += maxYPerRow + runSpacing;
        maxYPerRow = 0;
      }

      /// Устанавливаем смещение для текущего дочернего элемента
      final LimitWrapParentData childParentData =
          child!.parentData as LimitWrapParentData;
      childParentData.offset = Offset(dx, dy);

      /// Увеличиваем смещение для следующего дочернего элемента и индекс
      curIndex++;
      dx += childSize.width + spacing;

      /// Обновляем переменную последнего и предпоследнего отрисованного дочернего элемента
      /// и максимальное значение высоты для текущей строки
      penultimateRenderedChild = lastRenderedChild;
      penultimateRenderedChildOffset =
          (lastRenderedChild?.parentData as LimitWrapParentData?)?.offset;
      lastRenderedChild = child;
      maxYPerRow = max(maxYPerRow, childSize.height);

      /// Смотрим следующего ребенка
      child = childParentData.nextSibling;
    }

    /// Дальше происходит следующее:
    ///
    ///             Был ли добавлен виджет для отображения
    ///                 в случаем оверфлоу?
    ///                           |
    ///                           |Да
    ///                           |
    ///                 Есть ли переполнение?
    ///                        /        \
    ///                 Нет   /          \ Да
    ///                      /            \_____ _______
    ///                     /                   |           Нужно ли спрятать последний отрисованный элемент?
    ///                    /                    |                        /           \
    ///   Тогда просто не отрисовываем          |                 Нет   /             \ Да
    ///       оверфлоу виджет                   |                      /               \
    ///                                         |               ничего не           1. Уменьшаем смещение для следующего элемента
    ///                                         |                делаем              на ширину послднего дочернего элемента и величину [spacing]
    ///                                         |                                   2. Прячем последний элемент с помощбю лэйаута с нулевыми ограничениями
    ///                                         |
    ///                                         |
    ///                                         |________
    ///                                         |              Не посчитан ли еще оверфлоу?
    ///                                         |                      /           \
    ///                                         |            Посчитан /             \ Не посчитан
    ///                                         |                    /               \
    ///                                         |               ничего не          Скедулим микротаску (Важно: мы не можем начать
    ///                                         |                делаем                                перестроение когда еще не достроили вест [ExtendedRenderWrap]):
    ///                                         |                                      1. Поднимаем флаг [calculatedOverflow]
    ///                                         |                                      2. Вызываем [_onWidgetsLayouted]
    ///                                         |                                         передавая туда кол-во переполненных элементов без учета оверфлоу виджета
    ///                                         |                                      2. Cбрасываем кол-во переполненных элементов
    ///                                         |
    ///                                         |
    ///                                         |
    ///                                         |
    ///                              Отрисовывем оверфлоу виджет
    ///                                         |
    ///                                         |
    ///                                         |
    ///                                         |_____________
    ///                                         |                 Не убрался ли оверфлоу виджет (ИЛИ) не убрался только виджет для поиска хэштегов?
    ///                                         |                     (эта проверка происходит только тогда, когда поднят флаг
    ///                                         |                    что посичтано кол-во не убравшихся элементов [calculatedOverflow])
    ///                                         |                                      /           \
    ///                                         |                               Нет   /             \
    ///                                         |                                    /               \
    ///                                         |                                ничего не         1. Поднимаем флаг [isHideLastItemIfOverflowed] чтобы
    ///                                         |                                                     не отрисовывать последний элемент
    ///                                         |                                 делаем           2. Увеличиваем ко-во неубравшихся элементов на 1
    ///                                         |                                                  3. Скедулим микротаску:
    ///                                         |                                                     - 1. Вызываем [_onWidgetsLayouted] передавая
    ///                                         |                                                         туда кол-во переполненных элементов без учета оверфлоу виджета
    ///                                         |                                                     - 2. Cбрасываем кол-во переполненных элементов
    ///                                         |
    ///                                         |
    ///                                         |
    ///                                         |
    ///                  Обозначаем ограничения для всего родительского [RenderBox]
    ///
    if (isOverflowWidgetAdded) {
      final overflowRender = lastChild;
      if (!hasOverflow) {
        overflowRender?.layout(
          _shrinkedConstraints,
          parentUsesSize: true,
        );
      } else {
        if (isHideLastItemIfOverflowed) {
          dx -= lastRenderedChild!.size.width + spacing;

          /// Случай когда dx == 0 возможен если ребенок на последней строке занял всю ширину,
          /// в таком случае переносим оверфлоу виджет на предыдущую строку и смещаем вправо
          /// на ширину виджета с предыдущей строки
          if (dx == 0 &&
              penultimateRenderedChildOffset != null &&
              penultimateRenderedChild != null) {
            overflowRender?.layout(constraints, parentUsesSize: true);
            final size = overflowRender!.size;

            final potentialXOverflowWidgetEndOffset =
                penultimateRenderedChildOffset.dx +
                    penultimateRenderedChild.size.width +
                    spacing +
                    size.width;

            /// Если оверфлоу виджет не выходит за границу, то смещаем его
            if (potentialXOverflowWidgetEndOffset <= constraints.maxWidth) {
              dx += penultimateRenderedChildOffset.dx +
                  penultimateRenderedChild.size.width +
                  spacing;
              dy -= penultimateRenderedChild.size.height + runSpacing;
            }
          }
          lastRenderedChild.layout(
            _shrinkedConstraints,
            parentUsesSize: true,
          );
        }
        if (!calculatedOverflow) {
          Future.microtask(() {
            calculatedOverflow = true;
            _onWidgetsLayouted?.call(objectsOverflowed);
            objectsOverflowed = 0;
          });
        }

        overflowRender?.layout(constraints, parentUsesSize: true);
        final childParentData =
            overflowRender?.parentData as LimitWrapParentData?;
        childParentData?.offset = Offset(dx, dy);

        /// Более надежное условие, но отвечает меньшему количеству требований
        /// При критичесих багах вернуть его исопльзование
        ///
        ///if(childParentData!.offset.dx + overflowRender!.size.width > constraints.maxWidth && calculatedOverflow)
        final endOverflowRenderXOffset =
            childParentData!.offset.dx + overflowRender!.size.width;
        if ((endOverflowRenderXOffset > constraints.maxWidth ||
                objectsOverflowed == 1) &&
            calculatedOverflow) {
          isHideLastItemIfOverflowed = true;
          objectsOverflowed++;
          Future.microtask(() {
            _onWidgetsLayouted?.call(objectsOverflowed);
            objectsOverflowed = 0;
          });
        }
      }
    }
    size = constraints.constrain(Size(constraints.maxWidth, dy + maxYPerRow));
  }

  /// Добавляем [RenderBox]'ам возможность обрабатывать нажатия
  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  /// Отрисовываем результат
  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }
}
