import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:core/src/network/interceptor.dart';
import 'package:core/src/network/url.dart';
import 'package:dio/dio.dart';

class NetworkConfig {
  final Dio dio;

  String get baseUrl => NetworkUrl.baseUrl;

  static final _instance = NetworkConfig._();

  static NetworkConfig get instance => _instance;

  NetworkConfig._()
      : dio = Dio(
          BaseOptions(baseUrl: NetworkUrl.baseUrl),
        );

  void init(void Function() onRefreshTokenExpired) {
    dio.interceptors.add(
      RefreshTokenInterceptor(
        TokenStorage(),
        AuthWithRefreshTokenUseCase(),
        onRefreshTokenExpired,
      ),
    );
  }
}
