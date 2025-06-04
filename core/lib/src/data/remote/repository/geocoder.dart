import 'package:core/src/domain/repository/geocoder.dart';
import 'package:core/core.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:utils/utils.dart';

class GeocoderRepositoryI implements GeocoderRepository {
  final GeocoderDataSource _dataSource;

  GeocoderRepositoryI(this._dataSource);

  @override
  Future<Either<BaseError, Geolocation>> getGeolocationByPoint(
    LatLng point,
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
        city: res.city,
        street: res.street,
        building: res.building,
      );
      return Right(geoLocation);
    } catch (e, s) {
      return Left(BaseError(e.toString(), s));
    }
  }
}
