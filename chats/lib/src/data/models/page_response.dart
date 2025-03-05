import 'package:json_annotation/json_annotation.dart';

part 'page_response.g.dart';

@JsonSerializable()
class PageableResponseModel {
  final int number;
  final int size;
  final int totalElements;
  final int totalPages;

  PageableResponseModel({
    required this.number,
    required this.size,
    required this.totalElements,
    required this.totalPages,
  });

  factory PageableResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PageableResponseModelFromJson(json);
}
