part of '../page.dart';

final messages = List.generate(
  40,
  (index) => index.isEven
      ? MyMessageEntity(
          text: 'Привет, как дела?',
          timestamp: DateTime.now().subtract(Duration(hours: index * 5)),
          isChecked: false,
        )
      : FellowMessageEntity(
          timestamp: DateTime.now().subtract(Duration(hours: index * 5)),
          text: 'Привет, как дела?',
        ),
);

class _ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.base_0,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: context.colors.base_0,
          appBar: _ChatAppBarWidget(),
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'packages/chats/assets/images/background.png',
                ),
              ),
              SafeArea(
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
                          itemBuilder: (_, message) => _ChatMessageWidget(
                            message: message,
                          ),
                          groupSeparatorBuilder: (message) =>
                              _ChatDateSeparatorWidget(date: message.timestamp),
                          separator: SizedBox(
                            height: 8.toFigmaSize,
                          ),
                          elements: messages,
                        ),
                      ),
                      SizedBox(
                        height: 4.toFigmaSize,
                      ),
                      const InputWidget(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
