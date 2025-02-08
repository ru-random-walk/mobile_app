import 'package:bloc/bloc.dart';
import 'package:chats/src/domain/entity/meet_data/geolocation.dart';
import 'package:chats/src/domain/entity/meet_data/invite.dart';
import 'package:chats/src/domain/entity/message/message.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatLoading()) {
    on<LoadData>((event, emit) async {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(ChatData(_messages));
    });
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
          planDateOfMeeting: invite.date,
          planTimeOfMeeting: invite.time,
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
)..add(
    InvitationMessageEntity(
      timestamp: DateTime.now(),
      isMy: false,
      isChecked: false,
      planDateOfMeeting: DateTime.now()..add(const Duration(days: 1)),
      planTimeOfMeeting: TimeOfDay.now(),
      place: Geolocation(
        latitude: 341,
        longitude: 134,
        city: 'Москва',
        street: 'Пушкинская',
        building: '12',
      ),
      status: InvitationStatus.pending,
    ),
  )..sort(
        (a, b) => b.timestamp.compareTo(a.timestamp),);
