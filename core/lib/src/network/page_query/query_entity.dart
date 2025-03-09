part of 'page_query.dart';

class PageQuery {
  final int page;
  final int size;
  final List<String>? sort;

  PageQuery({
    required this.page,
    required this.size,
    required this.sort,
  });
}