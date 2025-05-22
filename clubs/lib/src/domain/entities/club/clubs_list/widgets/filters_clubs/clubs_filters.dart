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
    double width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.toFigmaSize),
      child: Row(
        children: List.generate(labels.length, (index) {
          final bool isSelected = selectedIndex == index;
          final String label = labels[index];

          if (label == "Управляемые") {
            width = 135.toFigmaSize;
          } else if (label == "В ожидании") {
            width = 120.toFigmaSize;
          } else {
            width = 115.toFigmaSize;
          }

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