import 'package:maplibre_gl/maplibre_gl.dart';

class Geolocation {
  final double latitude;
  final double longitude;
  final String? city;
  final String? street;
  final String? building;

  Geolocation({
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.street,
    this.building,
  });

  Geolocation copyWith({
    double? latitude,
    double? longitude,
    String? city,
    String? street,
    String? building,
  }) {
    return Geolocation(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      city: city ?? this.city,
      street: street ?? this.street,
      building: building ?? this.building,
    );
  }

  LatLng get point => LatLng(latitude, longitude);

  bool get hasDisplayName => city != null || street != null || building != null;

  @override
  String toString() {
    return '$street${building == null ? '' : ', $building'}';
  }
}
