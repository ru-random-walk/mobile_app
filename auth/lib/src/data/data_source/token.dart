import 'package:auth/src/data/models/token/request/base.dart';
import 'package:auth/src/data/models/token/response/response.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'token.g.dart';

@RestApi()
abstract class AuthDataSource {
  factory AuthDataSource(Dio dio, {String? baseUrl}) = _AuthDataSource;

  @POST('/auth/token')
  @Headers({'Content-Type': 'application/x-www-form-urlencoded'})
  Future<TokenResponseModel> auth(
    @Body() TokenRequestModel request,
    @Header('Authorization') String authorization,
  );
}
