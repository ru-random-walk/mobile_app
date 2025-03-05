class PageableResponse {
  final int number;
  final int size;
  final int totalElements;
  final int totalPages;

  PageableResponse({
    required this.number,
    required this.size,
    required this.totalElements,
    required this.totalPages,
  });
}