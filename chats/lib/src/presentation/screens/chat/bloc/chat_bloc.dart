import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chats/src/domain/entity/meet_data/geolocation.dart';
import 'package:chats/src/domain/entity/meet_data/invite.dart';
import 'package:chats/src/domain/entity/message/message.dart';
import 'package:chats/src/domain/use_case/get_messages.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetMessagesUseCase _getMessagesUseCase;

  ChatBloc(this._getMessagesUseCase) : super(ChatLoading()) {
    on<LoadData>(_onLoadData);
    on<TextMessageAdded>((event, emit) {
      final newMessage = TextMessageEntity(
        timestamp: DateTime.now(),
        isMy: true,
        isChecked: false,
        text: event.message,
      );
      final curMessages = (state as ChatData).messages;
      emit(
        ChatData(
          [
            ...curMessages,
            newMessage,
          ],
        ),
      );
    });
    on<InviteAdded>(
      (event, emit) {
        final curMessages = (state as ChatData).messages;
        final invite = event.invite;
        final newMessage = InvitationMessageEntity(
          timestamp: DateTime.now(),
          isMy: true,
          isChecked: false,
          planDateTimeOfMeeting: invite.date,
          place: invite.place,
          status: InvitationStatus.pending,
        );
        emit(
          ChatData(
            [
              ...curMessages,
              newMessage,
            ],
          ),
        );
      },
    );
  }

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
}

final _messages = List<MessageEntity>.generate(
  40,
  (index) => index.isEven
      ? TextMessageEntity(
          text: 'Привет, как дела?',
          timestamp: DateTime.now().subtract(Duration(hours: index * 5)),
          isChecked: false,
          isMy: false,
        )
      : TextMessageEntity(
          timestamp: DateTime.now().subtract(Duration(hours: index * 5)),
          text: 'Привет, как дела?',
          isMy: true,
          isChecked: true,
        ),
)
  ..add(
    InvitationMessageEntity(
      timestamp: DateTime.now(),
      isMy: false,
      isChecked: false,
      planDateTimeOfMeeting: DateTime.now()..add(const Duration(days: 1)),
      place: Geolocation(
        latitude: 341,
        longitude: 134,
        city: 'Москва',
        street: 'Пушкинская',
        building: '12',
      ),
      status: InvitationStatus.pending,
    ),
  )
  ..sort(
    (a, b) => b.timestamp.compareTo(a.timestamp),
  );
