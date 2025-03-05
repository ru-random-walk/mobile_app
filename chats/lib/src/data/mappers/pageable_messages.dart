import 'package:chats/src/data/mappers/message.dart';
import 'package:chats/src/data/mappers/page_response.dart';
import 'package:chats/src/data/models/messages/pageable_messages.dart';
import 'package:chats/src/domain/entity/message/pageable_messages.dart';

extension PageableMessageMapper on PageableMessagesModel {
  PageableMessagesEntity toDomain(String senderId) => PageableMessagesEntity(
        messages: content.map((e) => e.toDomain(senderId)).toList(),
        pageInfo: page.toDomain(),
      );
}
