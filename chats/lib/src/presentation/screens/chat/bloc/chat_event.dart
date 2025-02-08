part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class TextMessageAdded extends ChatEvent {
  final String message;

  TextMessageAdded({required this.message});
}

final class InviteAdded extends ChatEvent {
  final InviteEntity invite;

  InviteAdded({required this.invite});
}

final class LoadData extends ChatEvent {}
