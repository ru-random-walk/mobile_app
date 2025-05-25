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
              final navigator = Navigator.of(context);
              final result = await tryJoinInClub(
                clubId: clubId,
                userId: userId,
                apiService: clubApiService,
              );

              if (context.mounted && handleGraphQLErrors(context, result, fallbackMessage: 'Не удалось вступить в клуб')) return;

              final member = result?['data']?['tryJoinInClub'];

              final message = member != null
                  ? 'Вы успешно вступили в клуб'
                  : 'Не удалось вступить в клуб';
              
              if (context.mounted ) {
                ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), 
                  backgroundColor: member != null ? context.colors.main_50 : Colors.grey,),
              );
              }

              if (member != null) {
                navigator.pushReplacement(
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
              if (context.mounted) {
                showErrorSnackbar(context, 'Произошла ошибка: $e');
              }
            }
          },
        ),
      ),
    );
  }
}