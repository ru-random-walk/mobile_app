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
    final response = json['response'];
    final geoObjects = response['GeoObjectCollection']['featureMember'] as List<dynamic>;
    final mostRelevantResult = geoObjects.first;
    final address = mostRelevantResult['GeoObject']['metaDataProperty']['GeocoderMetaData']['Address'];
    final components = address['Components'] as List<dynamic>;
    final country = extractName('country', components);
    final city = extractName('locality', components);
    final street = extractName('street', components);
    final building = extractName('house', components);
    return GeoObjectModel(
      country: country,
      city: city,
      street: street,
      building: building,
    );
  }

  static String? extractName(String key, List<dynamic> components) {
    try {
      return (components.firstWhere((e) => e['kind'] == key) as Map<String, dynamic>)['name'];
    } catch (e) {
      return null;
    }
  }
}
