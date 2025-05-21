part of '../admin_page.dart';

class ConfirmationRequestRow extends StatelessWidget {
  final ClubApiService apiService;
  final String clubId;
  final String approverId;

  const ConfirmationRequestRow({
    super.key,
    required this.apiService,
    required this.clubId,
    required this.approverId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RequestListScreen(
              apiService: apiService,
              clubId: clubId,
              approverId: approverId,
            ),
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'Запрос на подтверждение',
                style: context.textTheme.bodyLRegular.copyWith(
                  color: context.colors.base_80,
                ),
              ),
              SizedBox(width: 8.toFigmaSize),
              Icon(
                Icons.arrow_forward_ios,
                size: 24.toFigmaSize,
                color: context.colors.base_50,
              ),
            ],
          ),
          // if (newRequests > 0)
          //   Container(
          //     width: 24.toFigmaSize,
          //     height: 24.toFigmaSize,
          //     decoration: BoxDecoration(
          //       color: context.colors.main_50,
          //       shape: BoxShape.circle,
          //     ),
          //     child: Center(
          //       child: Text(
          //         '$newRequests',
          //         style: context.textTheme.bodyMMedium.copyWith(
          //           color: context.colors.base_0,
          //         ),
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
