import 'dart:collection';

import 'package:chats/src/data/data_source/chat_socket.dart';
import 'package:chats/src/data/mappers/message.dart';
import 'package:chats/src/data/mappers/send_message.dart';
import 'package:chats/src/domain/entity/message/message.dart';
import 'package:chats/src/domain/entity/message/send_message.dart';
import 'package:chats/src/domain/repository/chat_messaging.dart';

class ChatMessagingRepository implements ChatMessagingRepositoryI {
  final ChatMessagingSocketSource _source;
  final String _currentUserId;
  final _sendMessageQueue = Queue<SendMessageEntity>();

  ChatMessagingRepository(this._source, this._currentUserId) {
    _source.init(_onInitialized);
  }

  @override
  Stream<MessageEntity> get messagesStream =>
      _source.messagesStream.map((e) => e.toDomain(_currentUserId));

  @override
  void sendMessage(SendMessageEntity sendMessage) {
    if (!_source.isInitialized) {
      _sendMessageQueue.add(sendMessage);
      return;
    }
    _source.sendMessage(sendMessage.toModel());
  }

  void _onInitialized() {
    while (_sendMessageQueue.isNotEmpty) {
      sendMessage(_sendMessageQueue.removeFirst());
    }
  }

  @override
  void dispose() => _source.dispose();
}
