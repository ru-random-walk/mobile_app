part of 'request_list_screen.dart';

class RequestWidget extends StatefulWidget {
  final String confirmationId;
  final String name;
  final String avatarPath;
  final ClubApiService apiService;

  const RequestWidget({
    super.key,
    required this.confirmationId, 
    required this.name, 
    required this.avatarPath,
    required this.apiService,
  });

  @override
  State<RequestWidget> createState() => _RequestWidgetState();
}

class _RequestWidgetState extends State<RequestWidget> {
  String? decision;
  
  Widget _defaultAvatar() {
    return Image.asset(
      'packages/clubs/assets/images/avatar.png',
      width: 80.toFigmaSize,
      height: 80.toFigmaSize,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.toFigmaSize),
      child: Row(
        children: [
          ClipOval(
            child: widget.avatarPath.isNotEmpty
              ? Image.network(
                  widget.avatarPath,
                  width: 80.toFigmaSize,
                  height: 80.toFigmaSize,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return _defaultAvatar(); 
                  },
                )
              : _defaultAvatar(),
          ),
          SizedBox(width: 16.toFigmaSize),
          SizedBox(
            height: 80.toFigmaSize,
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: context.textTheme.bodyXLMedium.copyWith(
                      color: context.colors.base_90,
                    ),
                  ),
                  decision == null
                    ? Row(
                      children: [
                        CustomButton(
                          text: 'Принять',
                          customWidth: 128.toFigmaSize,
                          customHeight: 40.toFigmaSize,
                          padding: EdgeInsets.all(8.toFigmaSize),
                          onPressed: () async {
                            try {
                              final result = await approveConfirmation(
                                confirmationId: widget.confirmationId,
                                apiService: widget.apiService,
                              );
                              if (handleGraphQLErrors(context, result, 
                                fallbackMessage: 'Ошибка принятия заявки')) return;
                              setState(() {
                                decision = 'approved';
                              });
                            } catch (e) {
                              print('$e');
                              showErrorSnackbar(context, 'Произошла ошибка');
                            }
                          },
                        ),
                        SizedBox(width: 20.toFigmaSize),
                        CustomButton(
                          text: 'Отклонить',
                          color: ButtonColor.green,
                          customColor: const Color(0xFFFF281A),
                          customWidth: 128.toFigmaSize,
                          customHeight: 40.toFigmaSize,
                          padding: EdgeInsets.all(8.toFigmaSize),
                          onPressed: () async {
                            try {
                              final result = await rejectConfirmation(
                                confirmationId: widget.confirmationId,
                                apiService: widget.apiService,
                              );
                              if (handleGraphQLErrors(context, result, 
                                fallbackMessage: 'Ошибка отклонения заявки')) return;
                              setState(() {
                                decision = 'rejected';
                              });
                            } catch (e) {
                              print('$e');
                              showErrorSnackbar(context, 'Произошла ошибка');
                            }
                          },
                        ),
                      ],
                    )
                  : Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.toFigmaSize),
                    child: Text(
                      decision == 'approved' ? 'Принято' : 'Отклонено',
                      style: context.textTheme.bodyLRegular.copyWith(
                        color: decision == 'approved'
                            ? context.colors.main_50
                            : const Color(0xFFED0005),
                      ),
                    ),
                  ),
                ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}
