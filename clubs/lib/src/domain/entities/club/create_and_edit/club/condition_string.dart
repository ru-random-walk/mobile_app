part of '../create_club_page.dart';

class ConditionString extends StatelessWidget {
  final int infoCount;
  final bool isConditionAdded;
  final VoidCallback onTap;
  final String conditionTitle;

  const ConditionString({
    super.key,
    required this.infoCount,
    required this.isConditionAdded,
    required this.onTap,
    required this.conditionTitle,
  });
  
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(conditionTitle,
              style: context.textTheme.bodyLRegular.copyWith(color: context.colors.base_70),
            ),
          ),
        ),),
        SizedBox(
          height: 22.toFigmaSize, 
          child: Align(
            alignment: Alignment.bottomCenter, 
            child: Text(
              "$infoCount ${conditionTitle == 'Запрос на вступление' ? inspectorWord(infoCount) : questionWord(infoCount)}",
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

String questionWord(int count) {
  int mod10 = count % 10;
  int mod100 = count % 100;
  
  if (mod10 == 1 && mod100 != 11) {
    return 'вопрос';
  } else if (mod10 >= 2 && mod10 <= 4 && !(mod100 >= 12 && mod100 <= 14)) {
    return 'вопроса';
  } else {
    return 'вопросов';
  }
}
