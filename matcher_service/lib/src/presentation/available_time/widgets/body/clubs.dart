part of '../../page.dart';

class _AvailableTimeClubsPicker extends StatefulWidget {
  final List<ShortClubEntity> clubs;

  const _AvailableTimeClubsPicker(this.clubs);

  @override
  State<_AvailableTimeClubsPicker> createState() =>
      _AvailableTimeClubsPickerState();
}

class _AvailableTimeClubsPickerState extends State<_AvailableTimeClubsPicker> {
  bool isOpened = false;

  @override
  Widget build(BuildContext context) {
    final parentState =
        context.findAncestorStateOfType<_AvailableTimeBodyWidgetState>();
    final clubsListNotifier = parentState!.selectedClubs;
    return Visibility(
      visible: widget.clubs.isNotEmpty,
      child: Padding(
        padding: EdgeInsets.all(4.toFigmaSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Фильтр по группам:',
              style: context.textTheme.bodyXLMedium,
            ),
            SizedBox(
              height: 12.toFigmaSize,
            ),
            LimitedWrapWidget(
              spacing: 12.toFigmaSize,
              runSpacing: 12.toFigmaSize,
              maxLines: isOpened ? null : 2,
              overflowWidgetBuilder: (amountOfOverflowedWidgets) {
                return ActionChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Еще $amountOfOverflowedWidgets',
                        style: context.textTheme.bodyMMedium.copyWith(
                          color: context.colors.base_0,
                        ),
                      ),
                      SizedBox(
                        width: 8.toFigmaSize,
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: context.colors.base_0,
                      ),
                    ],
                  ),
                  backgroundColor: context.colors.main_50,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.toFigmaSize),
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: () => setState(() => isOpened = true),
                  side: BorderSide.none,
                );
              },
              children: [
                for (final club in widget.clubs)
                  ValueListenableBuilder(
                    valueListenable: clubsListNotifier,
                    builder: (context, selectedClubs, _) {
                      final isSelected =
                          clubsListNotifier.value.contains(club);
                      return FilterChip(
                        selected: isSelected,
                        selectedColor: context.colors.main_50,
                        showCheckmark: false,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(16.toFigmaSize)),
                        side: isSelected
                            ? null
                            : BorderSide(
                                color: context.colors.base_70,
                                strokeAlign: BorderSide.strokeAlignInside),
                        backgroundColor: isSelected
                            ? context.colors.main_50
                            : context.colors.base_0,
                        label: Text(
                          club.name,
                          style: context.textTheme.bodyMMedium.copyWith(
                            color: isSelected
                                ? context.colors.base_0
                                : context.colors.base_70,
                          ),
                        ),
                        onSelected: (value) {
                          setState(() {
                            if (value) {
                              clubsListNotifier.value.add(club);
                            } else {
                              clubsListNotifier.value.remove(club);
                            }
                          });
                        },
                      );
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
