import 'dart:async';

import 'package:chats/src/domain/entity/meet_data/geolocation.dart';
import 'package:chats/src/domain/repository/geocoder.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class ReverseGeocodingUseCase implements BaseUseCase<BaseError, Geolocation, Point> {
  final GeocoderRepository _geocoderRepository;

  ReverseGeocodingUseCase(this._geocoderRepository);

  @override
  Future<Either<BaseError, Geolocation>> call(Point point) {
    return _geocoderRepository.getGeolocationByPoint(point);
  }
}