part of '../create_club_page.dart';

class ConditionString extends StatelessWidget {
  final int inspectorCount;
  final bool isConditionAdded;
  final VoidCallback onTap;

  const ConditionString({
    super.key,
    required this.inspectorCount,
    required this.isConditionAdded,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
          height: 36.toFigmaSize,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Запрос на вступление",
              style: context.textTheme.bodyLRegular.copyWith(color: context.colors.base_70),
            ),
          ),
        ),),
        SizedBox(
          height: 22.toFigmaSize, 
          child: Align(
            alignment: Alignment.bottomCenter, 
            child: Text(
              "$inspectorCount ${inspectorWord(inspectorCount)}",
              style: context.textTheme.bodySRegular.copyWith(color: context.colors.base_50),
            ),
          ),
        ),
        SizedBox(width: 16.toFigmaSize),
        GestureDetector(
          onTap: onTap,
          child: Icon(
            Icons.close,
            color: context.colors.base_30,
            size: 28.toFigmaSize,
          ),
        ),
      ],
    );
  }
}

String inspectorWord(int count) {
  int mod10 = count % 10;
  int mod100 = count % 100;
  
  if (mod10 == 1 && mod100 != 11) {
    return 'инспектор';
  } else if (mod10 >= 2 && mod10 <= 4 && !(mod100 >= 12 && mod100 <= 14)) {
    return 'инспектора';
  } else {
    return 'инспекторов';
  }
}
