part of '../page.dart';

class _ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.base_0,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: context.colors.base_0,
          appBar: _ChatAppBarWidget(),
          body: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'packages/chats/assets/images/background.png',
                  fit: BoxFit.cover,
                ),
              ),
              BlocBuilder<ChatBloc, ChatState>(
                builder: (_, state) => switch (state) {
                  ChatData _ => _ChatBodyData(),
                  ChatLoading _ => _ChatBodyLoading(),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
