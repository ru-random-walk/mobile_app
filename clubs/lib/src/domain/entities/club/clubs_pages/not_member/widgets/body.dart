part of '../not_member_page.dart';

class ClubNotMemberBody extends StatelessWidget {
  final String clubName;
  final String description;
  final int membersCount;
  final List<Map<String, dynamic>> approvements;
  final String clubId;
  final String userId;

  const ClubNotMemberBody({
    super.key,
    required this.clubName,
    required this.description,
    required this.membersCount,
    required this.approvements,
    required this.clubId,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
      vertical: 4.toFigmaSize,
      horizontal: 20.toFigmaSize,
    ),
      child: ListView(
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.toFigmaSize),
              child: SizedBox(
                width: 240.toFigmaSize,
                height: 240.toFigmaSize,
                child: Image.asset(
                  'packages/clubs/assets/images/avatar.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.toFigmaSize),
          Center(
            child: Text(
              clubName,
              style: context.textTheme.h4.copyWith(
                color: context.colors.base_90,
              ),
            ),
          ),
          SizedBox(height: 16.toFigmaSize),
          Row(
            children: [
              SvgPicture.asset(
                'packages/clubs/assets/icons/clubs.svg',
                width: 24.toFigmaSize,
                height: 24.toFigmaSize,
                colorFilter: ColorFilter.mode(
                  context.colors.base_80,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 4.toFigmaSize),
              Text(formatMemberCount(membersCount),
                style: context.textTheme.bodyLRegular.copyWith(
                color: context.colors.base_90,
              ),),
              const Spacer(),
              Text('Вы не в группе', 
                style: context.textTheme.bodyLRegular.copyWith(
                color: context.colors.base_50,
              ),),
            ],
          ),
          SizedBox(height: 16.toFigmaSize),
          Text(
            'Описание:',
            style: context.textTheme.bodyLMedium.copyWith(
            color: context.colors.base_90,
            ),
          ),
          Text(
            description,
            style: context.textTheme.bodyLRegular.copyWith(
            color: context.colors.base_80,
            ),
          ),
          if (approvements.isNotEmpty) ...[
            SizedBox(height: 16.toFigmaSize),
            Text(
              'Тесты для вступления',
              style: context.textTheme.bodyLMedium.copyWith(
                color: context.colors.base_90,
              ),
            ),
            SizedBox(height: 4.toFigmaSize),
            for (final approvement in approvements)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      approvement['type'] == 'FORM'
                          ? 'Тест'
                          : 'Запрос на вступление',
                      style: context.textTheme.bodyLRegular.copyWith(
                        color: context.colors.base_90,
                      ),
                    ),
                  ),
                  CustomButton(
                    text: approvement['type'] == 'FORM' ? 'Пройти' : 'Отправить',
                    customWidth: 140.toFigmaSize,
                    customHeight: 44.toFigmaSize,
                    padding: EdgeInsets.all(4.toFigmaSize),
                    onPressed: () async {
                      if (approvement['type'] == 'FORM') {
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
                                  membersCount: membersCount,),
                              ),
                            );
                          }
                        }
                      } else {
                        // отправить запрос на подтверждение
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 8.toFigmaSize),
          ],
        ],
      ),
    );
  }
}