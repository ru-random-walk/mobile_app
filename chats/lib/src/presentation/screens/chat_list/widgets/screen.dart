part of '../page.dart';

class _ChatsListScreen extends StatelessWidget {
  final String currentUserId;

  const _ChatsListScreen({
    super.key,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _ChatListAppBar(),
        body: BlocBuilder<ChatsListBloc, ChatsListState>(
          builder: (context, state) {
            return switch (state) {
              ChatsListLoading() => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ChatsListData() => _ChatListBodyData(
                  chats: state.chats,
                  currentUserId: currentUserId,
                ),
              // TODO: Handle this case.
              ChatsListError() => throw UnimplementedError(),
            };
          },
        ));
  }
}
