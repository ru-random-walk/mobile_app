import 'package:chats/src/data/data_source/geocoder.dart';
import 'package:chats/src/domain/entity/meet_data/geolocation.dart';
import 'package:chats/src/domain/repository/geocoder.dart';
import 'package:core/core.dart';
import 'package:core/src/error/base.dart';
import 'package:utils/src/either/either.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

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
      final coordinates = '$longitude,$latitude';
      final apiKey = EnvironmentVariables().yandexGeocoderApiKey;
      final res = await _dataSource.getGeolocationByPoint(apiKey, coordinates);
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
