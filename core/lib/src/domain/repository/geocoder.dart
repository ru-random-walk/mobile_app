import 'package:utils/utils.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../error/base.dart';
import '../enitites/geolocation.dart';

abstract interface class GeocoderRepository {
  Future<Either<BaseError, Geolocation>> getGeolocationByPoint(Point point);
}