import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chats/src/domain/entity/meet_data/invite.dart';
import 'package:chats/src/domain/entity/message/message.dart';
import 'package:chats/src/domain/repository/chat_messaging.dart';
import 'package:chats/src/domain/use_case/get_messages.dart';
import 'package:chats/src/domain/use_case/send_message.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetMessagesUseCase _getMessagesUseCase;
  final ChatMessagingRepositoryI _chatMessagingRepository;
  final SendMessageUseCase _sendMessageUseCase;

  ChatBloc(this._getMessagesUseCase, this._chatMessagingRepository,
      this._sendMessageUseCase)
      : super(ChatLoading()) {
    _initMessagesListener();
    on<LoadData>(_onLoadData);
    on<TextMessageSended>(_onTextMessageAdded);
    on<InviteMessageSended>(_onInviteMessageAdded);
    on<_MessageRecieved>(_onMessageReceived);
  }

  void _onMessageReceived(_MessageRecieved event, Emitter emit) {
    final newMessage = event.message;
    emit(
      ChatData(
        [
          newMessage,
          ..._currentMessages,
        ],
      ),
    );
  }

  void _initMessagesListener() {
    _chatMessagingRepository.messagesStream.listen((message) {
      log('Message received: ${message.timestamp}');
      add(_MessageRecieved(message: message));
    });
  }

  void _onTextMessageAdded(TextMessageSended event, Emitter emit) =>
      _sendMessageUseCase(
        TextMessageEntity(
          text: event.message,
          timestamp: DateTime.now(),
          isMy: true,
          isChecked: false,
        ),
      );

  void _onInviteMessageAdded(InviteMessageSended event, Emitter emit) =>
      _sendMessageUseCase(
        InvitationMessageEntity(
          timestamp: DateTime.now(),
          isMy: true,
          isChecked: false,
          planDateTimeOfMeeting: event.invite.date,
          place: event.invite.place,
          status: InvitationStatus.pending,
        ),
      );

  void _onLoadData(LoadData event, Emitter emit) async {
    if (_getMessagesUseCase.allPagesLoaded) return;
    final res = await _getMessagesUseCase();
    res.fold((e) {
      /// TODO
    }, (messages) {
      emit(
        ChatData(
          _currentMessages..addAll(messages),
        ),
      );
    });
  }

  List<MessageEntity> get _currentMessages {
    final localState = state;
    if (localState is ChatData) {
      return localState.messages;
    }
    return [];
  }

  @override
  Future<void> close() {
    _chatMessagingRepository.dispose();
    return super.close();
  }
}
