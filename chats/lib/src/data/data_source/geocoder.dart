import 'package:chats/src/data/models/geo_object.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'geocoder.g.dart';

const _yandexGeoCoderUrl = 'https://geocode-maps.yandex.ru';

@RestApi(baseUrl: _yandexGeoCoderUrl)
abstract class GeocoderDataSource {
  factory GeocoderDataSource() => _GeocoderDataSource(Dio());

  @GET('/1.x/')
  Future<GeoObjectModel> getGeolocationByPoint(
    @Query('apikey') String apiKey,
    @Query('geocode') String coordinates, [
    @Query('format') String type = 'json',
  ]);
}
