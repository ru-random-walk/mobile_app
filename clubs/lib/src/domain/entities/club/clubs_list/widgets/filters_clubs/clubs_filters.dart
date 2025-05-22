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

          final button = FilterButton(
            label: label,
            isSelected: isSelected,
            onPressed: () => onFilterChanged(index),
            height: 36.toFigmaSize,
          );
          if (label == "Все") {
            return Expanded(child: button);
          } else {
            return Padding(
              padding: EdgeInsets.only(left: 4.toFigmaSize),
              child: IntrinsicWidth(child: button),
            );
          }
        }),
      ),
    );
  }
}