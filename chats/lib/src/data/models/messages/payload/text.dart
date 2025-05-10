import 'package:chats/src/data/models/messages/payload/payload.dart';
import 'package:chats/src/data/models/messages/type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'text.g.dart';

@JsonSerializable()
class TextPayloadModel extends Payload implements SendablePayload {
  final String text;

  TextPayloadModel({required this.text}) : super(type: MessageType.text);

  factory TextPayloadModel.fromJson(Map<String, dynamic> json) =>
      _$TextPayloadModelFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final map = _$TextPayloadModelToJson(this);
    map['type'] = type.textValue;
    return map;
  }
}
