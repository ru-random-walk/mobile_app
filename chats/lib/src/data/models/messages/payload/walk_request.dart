import 'package:chats/src/data/models/date_converter.dart';
import 'package:chats/src/data/models/messages/payload/payload.dart';
import 'package:chats/src/data/models/messages/type.dart';
import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'walk_request.g.dart';

@JsonSerializable(
  converters: [
    DateJsonConverter(),
  ],
  explicitToJson: true,
)
class RequestForWalkPayloadModel extends Payload {
  final GeolocationModel location;
  final DateTime startsAt;
  final bool? answer;

  RequestForWalkPayloadModel({
    required this.location,
    required this.startsAt,
    required this.answer,
  }) : super(type: MessageType.requestForWalk);

  factory RequestForWalkPayloadModel.fromJson(Map<String, dynamic> json) =>
      _$RequestForWalkPayloadModelFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final map = _$RequestForWalkPayloadModelToJson(this);
    map['type'] = type.textValue;
    return map;
  }
}
