import 'package:core/src/data/data_source/geocoder.dart';
import 'package:core/src/data/models/query.dart';
import 'package:core/src/domain/repository/geocoder.dart';
import 'package:core/core.dart';
import 'package:core/src/error/base.dart';
import 'package:utils/utils.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../domain/enitites/geolocation.dart';

class GeocoderRepositoryI implements GeocoderRepository {
  final GeocoderDataSource _dataSource;

  GeocoderRepositoryI(this._dataSource);

  @override
  Future<Either<BaseError, Geolocation>> getGeolocationByPoint(
    Point point,
  ) async {
    try {
      final latitude = point.latitude;
      final longitude = point.longitude;
      final queryModel = GeocoderQueryModel(
        latitude: latitude,
        longitude: longitude,
      );
      final res = await _dataSource.getGeolocationByPoint(queryModel);
      final geoLocation = Geolocation(
        latitude: latitude,
        longitude: longitude,
        city: res.city ?? '',
        street: res.street ?? '',
        building: res.building,
      );
      return Right(geoLocation);
    } catch (e, s) {
      return Left(BaseError(e.toString(), s));
    }
  }
}
