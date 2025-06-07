part of 'base.dart';

@JsonSerializable(
  converters: [
    DateWithTimeZoneConverter(),
  ],
  explicitToJson: true,
  includeIfNull: false,
  createFactory: false,
)
class RequestForWalkPayloadModelRequest extends BaseRequestForWalkPayloadModel
    implements SendablePayload {
  RequestForWalkPayloadModelRequest({
    required super.location,
    required super.startsAt,
  });

  @override
  Map<String, dynamic> toJson() {
    final map = _$RequestForWalkPayloadModelRequestToJson(this);
    map['type'] = type.textValue;
    map['location']['type'] = 'location';
    return map;
  }
}
