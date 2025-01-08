import 'package:chats/src/domain/entity/meet_data/geolocation.dart';
import 'package:core/core.dart';
import 'package:utils/utils.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

abstract interface class GeocoderRepository {
  Future<Either<BaseError, Geolocation>> getGeolocationByPoint(Point point);
}