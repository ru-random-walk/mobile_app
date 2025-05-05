import 'dart:async';

import 'package:core/src/domain/repository/geocoder.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:utils/utils.dart';

import '../../error/base.dart';
import '../enitites/geolocation.dart';

class ReverseGeocodingUseCase implements BaseUseCase<BaseError, Geolocation, LatLng> {
  final GeocoderRepository _geocoderRepository;

  ReverseGeocodingUseCase(this._geocoderRepository);

  @override
  Future<Either<BaseError, Geolocation>> call(LatLng point) {
    return _geocoderRepository.getGeolocationByPoint(point);
  }
}