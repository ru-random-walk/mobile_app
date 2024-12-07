part of '../page.dart';

class _ChatScreen extends StatelessWidget {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'packages/chats/assets/images/background.png',
            ),
          ),
          ListView.separated(
            itemBuilder: (_, index) => _ChatMessageWidget(
              message: index.isEven
                  ? MyMessageEntity(
                      text: 'Привет, как дела?',
                      timestamp: DateTime.now(),
                      isChecked: false,
                    )
                  : FellowMessageEntity(
                      timestamp: DateTime.now(),
                      text:
                          'Привет, как дела? dfsdfsdf sd fs df  sd f sd f sdf s df s df sd f sdf  ',
                    ),
            ),
            separatorBuilder: (_, __) => SizedBox(height: 8.toFigmaSize),
            itemCount: 20,
          ),
        ],
      ),
    );
  }
}
