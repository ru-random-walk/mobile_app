import 'package:chats/src/data/models/chat/chat.dart';
import 'package:chats/src/data/models/messages/history/pageable_messages.dart';
import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'chat.g.dart';

@RestApi()
abstract class ChatDataSource {
  factory ChatDataSource() => _ChatDataSource(NetworkConfig.instance.dio);

  static const _prefix = '/chat';

  @GET('$_prefix/chat/list')
  Future<List<ChatModel>> getChatsList(
    @Queries() PageQueryModel queryModel,
    @Query('memberUsername') String memberUuid,
  );

  @GET('$_prefix/message/list')
  Future<PageableMessagesModel> getMessagesList(
    @Queries() PageQueryModel queryModel,
    @Query('chatId') String chatUuid,
  );
}
