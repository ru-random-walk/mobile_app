import 'dart:async';

import 'package:core/src/domain/repository/geocoder.dart';
import 'package:utils/utils.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../error/base.dart';
import '../enitites/geolocation.dart';

class ReverseGeocodingUseCase implements BaseUseCase<BaseError, Geolocation, Point> {
  final GeocoderRepository _geocoderRepository;

  ReverseGeocodingUseCase(this._geocoderRepository);

  @override
  Future<Either<BaseError, Geolocation>> call(Point point) {
    return _geocoderRepository.getGeolocationByPoint(point);
  }
}