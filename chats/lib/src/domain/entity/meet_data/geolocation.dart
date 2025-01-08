class Geolocation {
  final double latitude;
  final double longitude;
  final String city;
  final String street;
  final String? building;

  Geolocation({
    required this.latitude,
    required this.longitude,
    required this.city,
    required this.street,
    this.building,
  });

  @override
  String toString() {
    return '$street${building == null ? '' : ', $building'}';
  }
}
