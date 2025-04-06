import 'package:json_annotation/json_annotation.dart';

part 'mapper.dart';
part 'query_entity.dart';
part 'page_query.g.dart';

@JsonSerializable(includeIfNull: false, createFactory: false)
class PageQueryModel {
  final int page;
  final int size;
  @JsonKey(toJson: _sortToJson)
  final List<String>? sort;

  PageQueryModel({
    required this.page,
    required this.size,
    this.sort,
  });

  static String? _sortToJson(List<String>? sort) {
    if (sort == null) return null;
    return sort.join(',');
  }

  Map<String, dynamic> toJson() => _$PageQueryModelToJson(this);
}
