import 'package:json_annotation/json_annotation.dart';

part 'club_id.g.dart';

@JsonSerializable(createToJson: false)
class ClubIdModel {
  final String id;

  ClubIdModel({
    required this.id,
  });

  factory ClubIdModel.fromJson(Map<String, dynamic> json) =>
      _$ClubIdModelFromJson(json);
}
