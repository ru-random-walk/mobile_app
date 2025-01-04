part of 'geolocation_bloc.dart';

@immutable
sealed class GeolocationState {}

final class GeolocationLoading extends GeolocationState {}

final class GeolocationData extends GeolocationState {
  final String name;

  GeolocationData({required this.name});
}
