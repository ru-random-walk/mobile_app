part of '../not_member_page.dart';

class BottomButton extends StatelessWidget {
  final String clubId;
  final String userId;
  final ClubApiService clubApiService;

  const BottomButton({
    super.key,
    required this.clubId,
    required this.userId,
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
              final member = result?['addMemberInClub'];

              final message = member != null
                  ? 'Вы успешно вступили в клуб'
                  : 'Не удалось вступить в клуб';

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );

              if (member != null) {
                Navigator.pop(context);
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Ошибка: $e')),
              );
            }
          },
        ),
      ),
    );
  }
}