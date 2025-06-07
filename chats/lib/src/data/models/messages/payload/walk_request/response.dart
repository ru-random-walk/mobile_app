part of 'base.dart';

@JsonSerializable(
  converters: [
    DateWithTimeZoneConverter(),
  ],
  createToJson: false,
)
class RequestForWalkPayloadModelResponse
    extends BaseRequestForWalkPayloadModel {
  final bool? answer;
  final String? appointmentId;

  RequestForWalkPayloadModelResponse({
    required super.location,
    required super.startsAt,
    required this.answer,
    required this.appointmentId,
  });

  factory RequestForWalkPayloadModelResponse.fromJson(
          Map<String, dynamic> json) =>
      _$RequestForWalkPayloadModelResponseFromJson(json);
}
