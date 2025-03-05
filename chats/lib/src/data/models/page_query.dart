import 'package:json_annotation/json_annotation.dart';

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
    required this.sort,
  });

  static String? _sortToJson(List<String>? sort) {
    if (sort == null) return null;
    var res = '';
    for (var i = 0; i < sort.length; i++) {
      res += sort[i];
      if (i != sort.length - 1) {
        res += '&sort=';
      }
    }
    return res;
  }

  Map<String, dynamic> toJson() => _$PageQueryModelToJson(this);
}
