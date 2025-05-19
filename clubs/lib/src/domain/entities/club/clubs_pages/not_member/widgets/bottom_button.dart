part of '../not_member_page.dart';

class BottomButton extends StatelessWidget {
  final String clubId;
  final String userId;
  final int membersCount;
  final ClubApiService clubApiService;

  const BottomButton({
    super.key,
    required this.clubId,
    required this.userId,
    required this.membersCount,
    required this.clubApiService,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8.toFigmaSize,
        horizontal: 16.toFigmaSize,
      ),
      child: SizedBox(
        width: double.infinity,
        child: CustomButton(
          text: 'Вступить',
          onPressed: () async {
            try {
              final result = await addMemberInClub(
                clubId: clubId,
                memberId: userId,
                apiService: clubApiService,
              );

              if (handleGraphQLErrors(context, result, fallbackMessage: 'Не удалось вступить в клуб')) return;

              final member = result?['data']?['addMemberInClub'];

              final message = member != null
                  ? 'Вы успешно вступили в клуб'
                  : 'Не удалось вступить в клуб';

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );

              if (member != null) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MemberPage(
                      clubId: clubId,
                      currentId: userId,
                      membersCount: membersCount+1,
                    ),
                  ),
                );
              }
            } catch (e) {
              showErrorSnackbar(context, 'Произошла ошибка: $e');
            }
          },
        ),
      ),
    );
  }
}