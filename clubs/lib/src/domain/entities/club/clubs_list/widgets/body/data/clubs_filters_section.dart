part of '../../../page.dart';

class ClubFiltersSection extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onFilterChanged;

  const ClubFiltersSection({
    super.key,
    required this.selectedIndex,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8.toFigmaSize),
        ClubFilters(
          selectedIndex: selectedIndex,
          onFilterChanged: onFilterChanged,
        ),
        SizedBox(height: 8.toFigmaSize),
      ],
    );
  }
}
