part of 'chat_bloc.dart';

@immutable
sealed class ChatState {
  final UserEntity? companion;

  const ChatState(this.companion);
}

final class ChatLoading extends ChatState {
  const ChatLoading(super.companion);
}

final class ChatData extends ChatState {
  final List<MessageEntity> messages;

  const ChatData(
    this.messages,
    super.companion,
  );

  ChatData copyWith({List<MessageEntity>? messages}) => ChatData(
        messages ?? this.messages,
        companion,
      );
}
