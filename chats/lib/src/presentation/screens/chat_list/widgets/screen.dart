part of '../page.dart';

@visibleForTesting
class ChatsListScreen extends StatelessWidget {
  final String currentUserId;

  const ChatsListScreen({
    super.key,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChatsListBloc>();
    return Scaffold(
      appBar: _ChatListAppBar(),
      body: RefreshIndicator.adaptive(
        onRefresh: () async => bloc.add(GetChatsEvent(resetPagination: true)),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            BlocBuilder<ChatsListBloc, ChatsListState>(
              builder: (context, state) {
                return switch (state) {
                  ChatsListLoading() => const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ),
                  ChatsListData() => _ChatListBodyData(
                      chats: state.chats,
                      currentUserId: currentUserId,
                    ),
                  ChatsListError() => SliverFillRemaining(
                      child: Center(
                        child: Text(
                          'Что-то пошло не так',
                          style: context.textTheme.bodyMMedium,
                        ),
                      ),
                    ),
                  ChatsListEmpty() => const _ChatListBodyEmptyDataWidget(),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
