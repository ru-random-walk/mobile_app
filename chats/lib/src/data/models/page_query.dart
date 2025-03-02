class PageQueryModel {
  final int page;
  final int size;
  final List<String>? sort;

  PageQueryModel({
    required this.page,
    required this.size,
    required this.sort,
  });

  @override
  String toString() {
    var res = 'page=$page&size=$size';
    if (sort != null) {
      sort?.forEach((str) => res += '&sort=$str');
    }
    return res;
  }
}
