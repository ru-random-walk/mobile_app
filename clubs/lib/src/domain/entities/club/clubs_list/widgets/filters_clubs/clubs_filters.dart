part of '../../page.dart';

class ClubFilters extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onFilterChanged;

  const ClubFilters({
    super.key,
    required this.selectedIndex,
    required this.onFilterChanged,
  });
 
  @override
  Widget build(BuildContext context) {
    final List<String> labels = ["Все", "Управляемые", "В ожидании"];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.toFigmaSize),
      child: Row(
        children: List.generate(labels.length, (index) {
          final bool isSelected = selectedIndex == index;
          final String label = labels[index];

          final double width = (label == "Управляемые")
              ? 130.toFigmaSize
              : 120.toFigmaSize;

          final button = FilterButton(
            label: label,
            isSelected: isSelected,
            onPressed: () => onFilterChanged(index),
            width: width,
            height: 36.toFigmaSize,
          );
          if (index < labels.length - 1) {
            return Row(
              children: [
                button,
                SizedBox(width: 4.toFigmaSize),
              ],
            );
          } else {
            return button;
          }
        }),
      ),
    );
  }
}