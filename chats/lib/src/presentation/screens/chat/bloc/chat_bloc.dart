import 'dart:developer';

import 'package:chats/src/domain/entity/meet_data/invite.dart';
import 'package:chats/src/domain/entity/message/base.dart';
import 'package:chats/src/domain/repository/chat_messaging.dart';
import 'package:chats/src/domain/use_case/get_messages.dart';
import 'package:chats/src/domain/use_case/send_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcher_service/matcher_service.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetMessagesUseCase _getMessagesUseCase;
  final ChatMessagingRepositoryI _chatMessagingRepository;
  final SendMessageUseCase _sendMessageUseCase;
  final ApproveAppointmentRequestUseCase _approveAppointmentRequest;
  final RejectAppointmentRequestUseCase _rejectAppointmentRequest;

  ChatBloc(
      this._getMessagesUseCase,
      this._chatMessagingRepository,
      this._sendMessageUseCase,
      this._approveAppointmentRequest,
      this._rejectAppointmentRequest)
      : super(ChatLoading()) {
    _initMessagesListener();
    on<LoadData>(_onLoadData);
    on<TextMessageSended>(_onTextMessageAdded);
    on<InviteMessageSended>(_onInviteMessageAdded);
    on<_MessageRecieved>(_onMessageReceived);
    on<AppointmentRequestDecision>(_onAppointmentDecision);
    on<_WalkRequestStatusChangedEvent>(_onUpdateWalkRequestStatus);
    on<_AppointmentCreate>(_associateAppointmentWithMessage);
  }

  void _onAppointmentDecision(
    AppointmentRequestDecision event,
    Emitter emit,
  ) async {
    _updateMeetingData(
      event.messageId,
      emit,
      (invitation) => invitation.copyWith(
        status: InvitationStatus.loading,
      ),
    );
    final func = switch (event) {
      RejectAppointmentRequest _ => _rejectAppointmentRequest,
      ApproveAppointmentRequest _ => _approveAppointmentRequest,
    };
    func(event.appointmentId);
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
      log('Message received: ${DateTime.now().toIso8601String()}');
      switch (message) {
        case MessageEntity msg:
          add(_MessageRecieved(message: msg));
        case AppointmentCreatedSocketEvent event:
          add(_AppointmentCreate(event: event));
        case WalkRequestStatusChanged event:
          add(_WalkRequestStatusChangedEvent(event: event));
      }
    });
  }

  void _associateAppointmentWithMessage(
    _AppointmentCreate event,
    Emitter emit,
  ) =>
      _updateMeetingData(
        event.event.messageId,
        emit,
        (invtation) => invtation.copyWith(
          appointmentId: event.event.appointmentId,
          status: InvitationStatus.pending,
        ),
      );

  void _onUpdateWalkRequestStatus(
    _WalkRequestStatusChangedEvent event,
    Emitter emit,
  ) {
    final updateStatusEvent = event.event;
    final messageId = updateStatusEvent.messageId;
    final newStatus = updateStatusEvent.isAcccepted
        ? InvitationStatus.accepted
        : InvitationStatus.rejected;
    _updateMeetingData(
      messageId,
      emit,
      (invitation) => invitation.copyWith(
        status: newStatus,
      ),
    );
  }

  void _updateMeetingData(
    String messageId,
    Emitter emit,
    InvitationMessageEntity Function(InvitationMessageEntity invitation)
        copyWith,
  ) {
    final currentState = state;
    if (currentState is ChatData) {
      final messages = currentState.messages;
      final indexOfInvitation = messages.indexWhere(
        (msg) => msg.id == messageId,
      );
      if (indexOfInvitation == -1) return;
      final requestMessage = messages[indexOfInvitation];
      if (requestMessage is! InvitationMessageEntity) return;
      final newRequestMessage = copyWith(requestMessage);
      emit(
        currentState.copyWith(
          messages: [
            ...messages.sublist(0, indexOfInvitation),
            newRequestMessage,
            ...messages.sublist(indexOfInvitation + 1),
          ],
        ),
      );
    }
  }

  void _onTextMessageAdded(TextMessageSended event, Emitter emit) =>
      _sendMessageUseCase(
        TextMessageEntity(
          id: null,
          text: event.message,
          timestamp: DateTime.now(),
          isMy: true,
          isChecked: false,
        ),
      );

  void _onInviteMessageAdded(InviteMessageSended event, Emitter emit) {
    final date = event.invite.date;
    final timeInDate = Duration(
        hours: date.hour,
        minutes: date.minute,
        seconds: date.second,
        milliseconds: date.millisecond,
        microseconds: date.microsecond);
    final onlyDate = date.subtract(timeInDate);
    final selectedTime = event.invite.time;
    final inviteDateTime = onlyDate.add(
      Duration(
        hours: selectedTime.hour,
        minutes: selectedTime.minute,
      ),
    );
    _sendMessageUseCase(
      InvitationMessageEntity(
        appointmentId: null,
        id: null,
        timestamp: DateTime.now(),
        isMy: true,
        isChecked: false,
        planDateTimeOfMeeting: inviteDateTime,
        place: event.invite.place,
        status: InvitationStatus.pending,
      ),
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

  @override
  Future<void> close() {
    _chatMessagingRepository.dispose();
    return super.close();
  }
}
