import 'package:chats/src/data/models/geolocation.dart';
import 'package:chats/src/domain/entity/meet_data/geolocation.dart';

extension GeolocationMapper on GeolocationModel {
  Geolocation toDomain() => Geolocation(
        latitude: latitude,
        longitude: longitude,
        city: 'Пушкина',
        street: 'Колотушкина',
        building: '1',
      );
}
