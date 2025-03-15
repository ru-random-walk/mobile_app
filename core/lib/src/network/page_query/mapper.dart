part of 'page_query.dart';

extension PageableQueryMapper on PageQuery {
  PageQueryModel toModel() => PageQueryModel(
        page: page,
        size: size,
        sort: sort,
      );
}
