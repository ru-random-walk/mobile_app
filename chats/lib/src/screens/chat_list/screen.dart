part of 'page.dart';

class _ChatsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _ChatListAppBar(),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(
          vertical: 8.toFigmaSize,
          horizontal: 16.toFigmaSize,
        ),
        itemBuilder: (_, index) => DialogWidget(
          isInvitation: true,
          type: Readed(),
          text: 'Lorem Ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
          name: 'Maxim Seleznev',
          avatar: Image.network(
            'https://static.wikia.nocookie.net/adventuretimewithfinnandjake/images/9/97/S1e25_Finn_with_five_fingers.png/revision/latest/scale-to-width-down/971?cb=20131128031157',
            fit: BoxFit.cover,
          ),
        ),
        separatorBuilder: (_, __) => SizedBox(
          height: 16.toFigmaSize,
        ),
        itemCount: 20,
      ),
    );
  }
}
