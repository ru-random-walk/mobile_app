part of '../../page.dart';

class _ChatBodyData extends StatefulWidget {
  final String companionId;

  const _ChatBodyData({required this.companionId});

  @override
  State<_ChatBodyData> createState() => _ChatBodyDataState();
}

class _ChatBodyDataState extends State<_ChatBodyData> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChatBloc>();
    return BlocSelector<ChatBloc, ChatState, List<MessageEntity>>(
      selector: (state) => (state as ChatData).messages,
      builder: (context, messages) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.toFigmaSize),
              child: Column(
                children: [
                  Expanded(
                    child: StickyGroupedListView<MessageEntity, DateTime>(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.toFigmaSize,
                        vertical: 4.toFigmaSize,
                      ),
                      groupBy: (message) => DateTime(
                        message.timestamp.year,
                        message.timestamp.month,
                        message.timestamp.day,
                      ),
                      floatingHeader: true,
                      reverse: true,
                      order: StickyGroupedListOrder.DESC,
                      indexedItemBuilder: (_, message, index) {
                        if (index == messages.length - 5) {
                          bloc.add(LoadData(widget.companionId));
                        }
                        return _ChatMessageWidget(
                          message: message,
                        );
                      },
                      itemComparator: (msg1, msg2) =>
                          msg1.timestamp.compareTo(msg2.timestamp),
                      groupComparator: (date1, date2) => date1.compareTo(date2),
                      groupSeparatorBuilder: (message) =>
                          _ChatDateSeparatorWidget(
                        date: message.timestamp,
                      ),
                      separator: SizedBox(
                        height: 8.toFigmaSize,
                      ),
                      elements: messages,
                    ),
                  ),
                  SizedBox(
                    height: 4.toFigmaSize,
                  ),
                  InputWidget(
                    onLogoTap: () async {
                      final res = await showDialog(
                        context: context,
                        builder: (context) => _MeetDataDialogWidget(),
                      );
                      if (res is InviteEntity) {
                        bloc.add(
                          InviteMessageSended(invite: res),
                        );
                      }
                    },
                    onSend: (text) => bloc.add(
                      TextMessageSended(message: text),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
