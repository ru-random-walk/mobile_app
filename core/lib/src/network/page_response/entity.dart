import 'package:json_annotation/json_annotation.dart';

part 'mapper.dart';
part 'model.dart';
part 'entity.g.dart';

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