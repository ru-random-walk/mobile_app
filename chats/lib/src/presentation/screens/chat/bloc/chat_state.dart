part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatLoading extends ChatState {}

final class ChatData extends ChatState {
  final List<MessageEntity> messages;
  ChatData(this.messages);

  ChatData copyWith({List<MessageEntity>? messages}) => ChatData(
        messages ?? this.messages,
      );
}
