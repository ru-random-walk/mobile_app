import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:chats/src/data/models/messages/message.dart';
import 'package:chats/src/data/models/messages/socket/request/message_request.dart';
import 'package:core/core.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class ChatMessagingSocketSource {
  final TokenStorage _tokenStorage;
  final String chatId;
  final _messageController = StreamController<MessageModel>.broadcast();
  late final StompClient _client;

  Stream<MessageModel> get messagesStream => _messageController.stream;

  ChatMessagingSocketSource({
    required TokenStorage tokenStorage,
    required this.chatId,
  }) : _tokenStorage = tokenStorage;

  String get _messageRecieveTopic => '/topic/chat/$chatId';

  String get _messageSendTopic => '/app/sendMessage';

  bool get isInitialized => _client.isActive;

  StompConfig _getConfig(
    Map<String, String> authHeaders,
    void Function() onConnect,
  ) =>
      StompConfig.sockJS(
        url: '${NetworkConfig.instance.baseUrl}/chat/ws',
        stompConnectHeaders: authHeaders,
        webSocketConnectHeaders: authHeaders,
        onConnect: (frame) {
          onConnect();
          _onConnect(frame);
        },
        onStompError: (frame) => log(frame.body ?? ''),
        onWebSocketError: (frame) => log(frame.body ?? ''),
        onDisconnect: (frame) => log(frame.body ?? ''),
        onDebugMessage: (msg) => log(msg),
        onWebSocketDone: () {
          log(StackTrace.current.toString());
          log('Socket is done');
        },
        onUnhandledFrame: (frame) => log(frame.body ?? ''),
        onUnhandledMessage: (frame) => log(frame.body ?? ''),
        onUnhandledReceipt: (rec) => log(rec.body ?? ''),
      );

  Future<void> init(void Function() onInitialized) async {
    final headers = await _authHeaders;
    final config = _getConfig(headers, onInitialized);
    _client = StompClient(config: config);
    _client.activate();
  }

  Future<Map<String, String>> get _authHeaders async {
    final accessToken = await _tokenStorage.getToken();
    final tokenType = await _tokenStorage.getTokenType();
    return {
      'Authorization': '$tokenType $accessToken',
    };
  }

  void _onConnect(StompFrame frame) {
    _client.subscribe(
      destination: _messageRecieveTopic,
      callback: _onFrameReceieved,
    );
  }

  void _onFrameReceieved(StompFrame frame) {
    try {
      final data = frame.body;
      final json = jsonDecode(data ?? '');
      final message = BaseSocketResponseMessageModel.fromJson(json);
      _messageController.add(message);
    } catch (e) {
      log(e.toString());
    }
  }

  void sendMessage(SendMessageModel message) {
    final body = jsonEncode(message.toJson());
    log('Message body:\n$body');
    _client.send(
      destination: _messageSendTopic,
      body: body,
    );
  }

  void dispose() {
    _client.deactivate();
    _messageController.close();
  }
}
