part of 'chats_list_bloc.dart';

@immutable
sealed class ChatsListEvent {}

class GetChatsEvent extends ChatsListEvent {
  final bool resetPagination;

  GetChatsEvent({required this.resetPagination});
}

class LastMessageChatUpdated extends ChatsListEvent {
  final String chatId;
  final MessageEntity? message;

  LastMessageChatUpdated({
    required this.chatId,
    required this.message,
  });
}
