import 'package:chats/src/data/models/geolocation.dart';
import 'package:chats/src/data/models/messages/payload.dart';
import 'package:chats/src/data/models/messages/type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'walk_request.g.dart';

@JsonSerializable()
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
}
