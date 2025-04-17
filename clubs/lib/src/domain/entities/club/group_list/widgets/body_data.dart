part of '../../screens.dart';

class GroupListBodyData extends StatelessWidget {
  final List<Map<String, String>> groups;

  const GroupListBodyData({
    super.key, 
    required this.groups,
    });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: 16.toFigmaSize, 
          vertical: 8.toFigmaSize,
        ),
        itemBuilder: (_, index) {
          final group = groups[index];
          return GroupWidget(
            image: group["image"] ?? "",
            title: group["title"] ?? "",
            subscribers: group["subtitle"] ?? "",
            onTap: () {
              // Navigator.push(...);
            },
          );
        },
        separatorBuilder: (_, __) => SizedBox(
          height: 4.toFigmaSize,
        ),
        itemCount: groups.length,
      ),
    );
  }
}