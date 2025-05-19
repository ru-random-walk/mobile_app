part of '../not_member_page.dart';

class JoinRequirements extends StatelessWidget {
  final List<Map<String, dynamic>> approvements;
  final String clubId;
  final String userId;
  final int membersCount;

  const JoinRequirements({
    super.key,
    required this.approvements,
    required this.clubId,
    required this.userId,
    required this.membersCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16.toFigmaSize),
        Text(
          'Тесты для вступления',
          style: context.textTheme.bodyLMedium.copyWith(
            color: context.colors.base_90,
          ),
        ),
        SizedBox(height: 4.toFigmaSize),
        ...approvements.map((approvement) {
          final isTest = approvement['type'] == 'FORM';
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      isTest ? 'Тест' : 'Запрос на вступление',
                      style: context.textTheme.bodyLRegular.copyWith(
                        color: context.colors.base_90,
                      ),
                    ),
                  ),
                  CustomButton(
                    text: isTest ? 'Пройти' : 'Отправить',
                    customWidth: 140.toFigmaSize,
                    customHeight: 44.toFigmaSize,
                    padding: EdgeInsets.all(4.toFigmaSize),
                    onPressed: () async {
                      if (isTest) {
                        final result = await Navigator.of(context).push<bool>(
                          MaterialPageRoute(
                            builder: (_) => TestFormScreen(clubId: clubId),
                          ),
                        );

                        if (result != null) {
                          final shouldReplace = await Navigator.of(context).push<bool>(
                            MaterialPageRoute(
                              builder: (_) => TestResultScreen(result: result),
                            ),
                          );
                          if (shouldReplace == true) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => MemberPage(
                                  clubId: clubId,
                                  currentId: userId,
                                  membersCount: membersCount,
                                ),
                              ),
                            );
                          }
                        }
                      } else {
                        // обработка запроса
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 8.toFigmaSize),
            ],
          );
        }).toList(),
      ],
    );
  }
}
