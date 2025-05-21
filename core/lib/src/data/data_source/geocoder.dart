import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../models/geo_object.dart';
import '../models/query.dart';

part 'geocoder.g.dart';

const _dadataGeoCoderUrl = 'https://suggestions.dadata.ru';

@RestApi(baseUrl: _dadataGeoCoderUrl)
abstract class GeocoderDataSource {
  factory GeocoderDataSource() => _GeocoderDataSource(Dio());

  @POST('/suggestions/api/4_1/rs/geolocate/address')
  @Headers(headers)
  Future<GeoObjectModel> getGeolocationByPoint(
    @Body() GeocoderQueryModel queryModel, [
    @Header('Authorization') String token = 'Token $dadataToken',
  ]);
}

const dadataToken = String.fromEnvironment('DADATA_API_KEY');

const headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
};
