part of 'geolocation_bloc.dart';

@immutable
sealed class GeolocationState {}

final class GeolocationLoading extends GeolocationState {}

final class GeolocationFailure extends GeolocationState {}

final class GeolocationData extends GeolocationState {
  final Geolocation geolocation;

  GeolocationData({required this.geolocation});
}
