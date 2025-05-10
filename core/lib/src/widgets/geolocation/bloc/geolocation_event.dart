part of 'geolocation_bloc.dart';

@immutable
sealed class GeolocationEvent {}

final class GetLocationNameByPoint extends GeolocationEvent {
  final LatLng point;
  final int? zoom;

  GetLocationNameByPoint({
    required this.point,
    this.zoom,
  });
}
