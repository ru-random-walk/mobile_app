import 'package:chats/src/data/models/geolocation.dart';
import 'package:core/core.dart';

extension GeolocationMapper on GeolocationModel {
  Geolocation toDomain() => Geolocation(
        latitude: latitude,
        longitude: longitude,
        city: city,
        street: street,
        building: building,
      );
}

extension GeolocationMapperToModel on Geolocation {
  GeolocationModel toModel() => GeolocationModel(
        latitude: latitude,
        longitude: longitude,
        city: city,
        street: street,
        building: building,
      );
}
