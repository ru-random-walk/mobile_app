part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class TextMessageSended extends ChatEvent {
  final String message;

  TextMessageSended({required this.message});
}

final class InviteMessageSended extends ChatEvent {
  final InviteEntity invite;

  InviteMessageSended({required this.invite});
}

final class _MessageRecieved extends ChatEvent {
  final MessageEntity message;

  _MessageRecieved({required this.message});
}

final class LoadData extends ChatEvent {}
