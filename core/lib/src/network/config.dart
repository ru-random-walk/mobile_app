import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:core/src/network/interceptor.dart';
import 'package:core/src/network/url.dart';
import 'package:dio/dio.dart';

class NetworkConfig {
  final Dio dio;

  static final _instance = NetworkConfig._();

  static NetworkConfig get instance => _instance;

  NetworkConfig._()
      : dio = Dio(
          BaseOptions(baseUrl: Url.baseUrl),
        );

  void init() {
    dio.interceptors.add(
      RefreshTokenInterceptor(
        TokenStorage(),
        AuthWithRefreshTokenUseCase(),
      ),
    );
  }
}
