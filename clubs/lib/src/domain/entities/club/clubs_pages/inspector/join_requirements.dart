part of 'inspector_page.dart';

class JoinRequirementsInspector extends StatelessWidget {
  final List<Map<String, dynamic>> approvements;
  final String clubId;
  final String userId;
  final ClubApiService apiService;

  const JoinRequirementsInspector({
    super.key,
    required this.approvements,
    required this.clubId,
    required this.userId,
    required this.apiService,
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
          final type = approvement['type'] as String?;
          if (type == 'FORM') {
            return Text(
              'Тест',
              style: context.textTheme.bodyLRegular.copyWith(
                color: context.colors.base_80,
              ),
            );
          } else {
            return ConfirmationRequestRow(
              apiService: apiService,
              clubId: clubId,
              approverId: userId,
            );
          }
        }),
      ],
    );
  }
}
