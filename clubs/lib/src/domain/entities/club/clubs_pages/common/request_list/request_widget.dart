part of 'request_list_screen.dart';

class RequestWidget extends StatefulWidget {
  final String confirmationId;
  final UserEntity user;
  final ClubApiService apiService;

  const RequestWidget({
    super.key,
    required this.confirmationId,
    required this.user,
    required this.apiService,
  });

  @override
  State<RequestWidget> createState() => _RequestWidgetState();
}

class _RequestWidgetState extends State<RequestWidget> {
  String? decision;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.toFigmaSize),
      child: Row(
        children: [
          AvatarUserWidget(
            user: widget.user,
            size: 80.toFigmaSize,
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
                      widget.user.fullName,
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
                                    if (context.mounted && handleGraphQLErrors(context, result,
                                        fallbackMessage:
                                            'Ошибка принятия заявки')) {
                                      return;
                                    }
                                    setState(() {
                                      decision = 'approved';
                                    });
                                  } catch (e) {
                                    if (kDebugMode) {
                                      print('$e');
                                    }
                                    if (context.mounted) {
                                      showErrorSnackbar(
                                        context, 'Произошла ошибка');
                                    }
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
                                    if (context.mounted && handleGraphQLErrors(context, result,
                                        fallbackMessage:
                                            'Ошибка отклонения заявки')) {
                                      return;
                                    }
                                    setState(() {
                                      decision = 'rejected';
                                    });
                                  } catch (e) {
                                    if (kDebugMode) {
                                      print('$e');
                                    }
                                    if (context.mounted) {
                                      showErrorSnackbar(
                                        context, 'Произошла ошибка');
                                    }
                                  }
                                },
                              ),
                            ],
                          )
                        : Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: 8.toFigmaSize),
                            child: Text(
                              decision == 'approved' ? 'Принято' : 'Отклонено',
                              style: context.textTheme.bodyLRegular.copyWith(
                                color: decision == 'approved'
                                    ? context.colors.main_50
                                    : const Color(0xFFED0005),
                              ),
                            ),
                          ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}
