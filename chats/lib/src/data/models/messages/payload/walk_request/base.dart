import 'package:chats/src/data/models/date_converter.dart';
import 'package:chats/src/data/models/messages/payload/payload.dart';
import 'package:chats/src/data/models/messages/type.dart';
import 'package:core/core.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base.g.dart';
part 'request.dart';
part 'response.dart';

sealed class BaseRequestForWalkPayloadModel extends Payload {
  final GeolocationModel location;
  final DateTime startsAt;

  BaseRequestForWalkPayloadModel({
    required this.location,
    required this.startsAt,
  }) : super(type: MessageType.requestForWalk);
}
