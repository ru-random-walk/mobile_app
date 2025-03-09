import 'dart:async';

import 'package:chats/src/domain/entity/message/message.dart';
import 'package:chats/src/domain/entity/message/send_message.dart';
import 'package:chats/src/domain/repository/chat_messaging.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';

class SendMessageUseCase implements BaseUseCase<BaseError, void, MessageEntity> {
  final ChatMessagingRepositoryI _chatMessagingRepository;
  final String chatId;
  final String senderId;
  final String recepientId;

  SendMessageUseCase(
    this._chatMessagingRepository,
    this.chatId,
    this.senderId,
    this.recepientId,
  );

  @override
  FutureOr<Either<BaseError, void>> call(MessageEntity params) {
    final messagee = SendMessageEntity(
      message: params,
      chatId: chatId,
      sender: senderId,
      recepient: recepientId,
      createdAt: params.timestamp,
    );
    return Right(_chatMessagingRepository.sendMessage(messagee));
  }
}
