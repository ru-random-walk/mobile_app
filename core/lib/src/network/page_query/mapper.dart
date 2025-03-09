part of 'page_query.dart';

extension PageableMapper on PageQuery {
  PageQueryModel toModel() => PageQueryModel(
        page: page,
        size: size,
        sort: sort,
      );
}
