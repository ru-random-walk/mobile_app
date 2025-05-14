part of 'admin_page.dart';

class ClubAdminBody extends StatelessWidget {
  final String title;
  final String description;
  final List<Map<String, dynamic>> approvement;
  final List<Map<String, dynamic>> members;

  const ClubAdminBody({
    super.key,
    required this.title,
    required this.description,
    required this.approvement,
    required this.members,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        vertical: 4.toFigmaSize,
        horizontal: 20.toFigmaSize,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              title,
              style: context.textTheme.h4.copyWith(
                    color: context.colors.base_90,
                  ),
            ),
          ),
          SizedBox(height: 20.toFigmaSize),
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
          if (approvement.isNotEmpty) ...[
            SizedBox(height: 20.toFigmaSize),
            Text(
              'Тесты для вступления:',
              style: context.textTheme.bodyLMedium.copyWith(
                color: context.colors.base_90,
              ),
            ),
            ...approvement
                .where((a) => a['type'] == 'FORM' || a['type'] == 'MEMBER_CONFIRM')
                .map((a) {
              final type = a['type'];
              if (type == 'FORM') {
                final testName = a['name'] ?? 'Без названия';
                return Text(
                  'Тест: $testName',
                  style: context.textTheme.bodyLRegular.copyWith(
                    color: context.colors.base_80,
                  ),
                );
              } else {
                return Text(
                  'Запрос на подтверждение',
                  style: context.textTheme.bodyLRegular.copyWith(
                    color: context.colors.base_80,
                  ),
                );
              }
            }),
          ],
          SizedBox(height: 20.toFigmaSize),
          Row(
            children: [
              SvgPicture.asset(
                'packages/clubs/assets/icons/clubs.svg',
                width: 28.toFigmaSize,
                height: 28.toFigmaSize,
                colorFilter: ColorFilter.mode(
                  context.colors.base_80,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 4.toFigmaSize),
              Text(
                formatMemberCount(members.length),
                style: context.textTheme.bodyLMedium.copyWith(
                  color: context.colors.base_90,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.toFigmaSize),

          MemberTile(
            name: 'Нюша',
            role: 'Участник',
            avatarPath: 'packages/clubs/assets/images/avatar.png',
            onMenuPressed: () {
              // открыть оверлей
            },
          ),
          MemberTile(
            name: 'Нюша',
            role: 'Участник',
            avatarPath: 'packages/clubs/assets/images/avatar.png',
            onMenuPressed: () {
              // открыть оверлей
            },
          ),
        ],
      ),
    );
  }
}

String formatMemberCount(int count) {
    final mod10 = count % 10;
    final mod100 = count % 100;

    String suffix;
    if (mod100 >= 11 && mod100 <= 14) {
      suffix = 'участников';
    } else if (mod10 == 1) {
      suffix = 'участник';
    } else if (mod10 >= 2 && mod10 <= 4) {
      suffix = 'участника';
    } else {
      suffix = 'участников';
    }

    return '$count $suffix';
  }
