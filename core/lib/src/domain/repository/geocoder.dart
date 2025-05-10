import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:utils/utils.dart';

import '../../error/base.dart';
import '../enitites/geolocation.dart';

abstract interface class GeocoderRepository {
  Future<Either<BaseError, Geolocation>> getGeolocationByPoint(LatLng point);
}