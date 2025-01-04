part of 'geolocation_bloc.dart';

@immutable
sealed class GeolocationEvent {}

final class GetLocationNameByPoint extends GeolocationEvent {
  final Point point;
  final int? zoom;

  GetLocationNameByPoint({
    required this.point,
    this.zoom,
  });
}
