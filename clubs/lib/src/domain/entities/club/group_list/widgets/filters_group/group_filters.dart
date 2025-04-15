part of '../../../screens.dart';

class GroupFilters extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onFilterChanged;

  const GroupFilters({
    super.key,
    required this.selectedIndex,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> labels = ["Все", "Управляемые", "В ожидании"];

    return Row(
      children: [ 
        SizedBox(width: 16.toFigmaSize),
        ...List.generate(labels.length, (index) {
          final bool isSelected = selectedIndex == index;
          final String label = labels[index];
          final bool isFlexible = label == "Все";

          final button = Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.toFigmaSize),
            child: FilterButton(
              label: label,
              isSelected: isSelected,
              onPressed: () => onFilterChanged(index),
              width: isFlexible ? double.infinity : null,
              height: 36.toFigmaSize,
            ),
          );

          return isFlexible ? Expanded(child: button) : button;
        }),
        SizedBox(width: 16.toFigmaSize),
      ],
    );
  }
}