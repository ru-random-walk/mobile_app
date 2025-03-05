part of 'chats_list_bloc.dart';

@immutable
sealed class ChatsListState {}

final class ChatsListLoading extends ChatsListState {}

final class ChatsListData extends ChatsListState {
  final List<ChatEntity> chats;

  ChatsListData({required this.chats});
}

final class ChatsListError extends ChatsListState {
  final BaseError error;

  ChatsListError({required this.error});
}
