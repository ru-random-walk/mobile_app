import 'package:chats/src/data/models/page_response.dart';
import 'package:chats/src/domain/entity/chat/page_response.dart';

extension PageableMapper on PageableResponseModel {
  PageableResponse toDomain() => PageableResponse(
        size: size,
        totalElements: totalElements,
        totalPages: totalPages,
        number: number,
      );
}
