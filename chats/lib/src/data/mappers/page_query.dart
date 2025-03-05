import 'package:chats/src/data/models/page_query.dart';
import 'package:chats/src/domain/entity/chat/page_query.dart';

extension PageableMapper on PageQuery {
  PageQueryModel toModel() => PageQueryModel(
        page: page,
        size: size,
        sort: sort,
      );
}
