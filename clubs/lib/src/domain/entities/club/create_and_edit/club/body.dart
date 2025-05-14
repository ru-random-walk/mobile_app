part of '../create_club_page.dart';

class ClubFormBody extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final bool isConditionAdded;
  final String conditionName;
  final int infoCount;
  final void Function(String, int, String, List<Map<String, dynamic>>? questions) onConditionAdded;
  final void Function() removeCondition;

  const ClubFormBody({
    Key? key,
    required this.nameController,
    required this.descriptionController,
    required this.isConditionAdded,
    required this.conditionName,
    required this.infoCount,
    required this.onConditionAdded,
    required this.removeCondition,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 20.toFigmaSize,
        vertical: 8.toFigmaSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.toFigmaSize),
              child: SizedBox(
                width: 120.toFigmaSize,
                height: 120.toFigmaSize,
                child: Image.asset(
                  'packages/clubs/assets/images/avatar.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 8.toFigmaSize),
          // Button
          SizedBox(height: 12.toFigmaSize),

          Text('Название группы', style: context.textTheme.bodyXLMedium),
          SizedBox(height: 8.toFigmaSize),
          TextFieldGroup(
            num: 1,
            controller: nameController,
            title: 'Название',
          ),
          SizedBox(height: 20.toFigmaSize),

          Text('Описание', style: context.textTheme.bodyXLMedium),
          SizedBox(height: 8.toFigmaSize),
          TextFieldGroup(
            num: 3,
            controller: descriptionController,
            title: 'Описание',
          ),
          SizedBox(height: 20.toFigmaSize),

          Text('Условия для вступления', style: context.textTheme.bodyXLMedium),
          SizedBox(height: 8.toFigmaSize),

          if (!isConditionAdded)
            CreateGroupButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return _AddTestDialog(
                      onConditionAdded: onConditionAdded,
                      infoCount: infoCount,
                      conditionName: conditionName,
                    );
                  },
                ).then((result) {
                  if (result != null) {
                    String testName = result['testName'];
                    int questionCount = result['questionCount'];
                    String attempts = result['attempts'];
                    List<Map<String, dynamic>> questions = result['questions'];

                    onConditionAdded(attempts, questionCount, testName, questions); 
                    }
                  });
                },
              ),
          if (isConditionAdded)
            ConditionString(
              infoCount: infoCount,
              isConditionAdded: isConditionAdded,
              onTap: removeCondition,
              conditionTitle: conditionName,
            ),
        ],
      ),
    );
  }
}