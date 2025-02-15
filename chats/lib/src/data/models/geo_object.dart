class GeoObjectModel {
  final String? country;
  final String? city;
  final String? street;
  final String? building;

  GeoObjectModel({
    required this.country,
    required this.city,
    required this.street,
    required this.building,
  });

  factory GeoObjectModel.fromJson(Map<String, dynamic> json) {
    final response = (json['suggestions'] as List<dynamic>).first;
    final data = response['data'];
    final country = data['country'] as String?;
    final city = data['city'] as String?;
    final street = data['street'] as String?;
    final building = data['house'] as String?;
    final blockType = data['block_type'] as String?;
    final block = data['block'] as String?;
    return GeoObjectModel(
      country: country,
      city: city,
      street: street,
      building: (building ?? '') + (blockType ?? '') + (block ?? ''),
    );
  }
}
