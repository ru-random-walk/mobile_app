import 'dart:developer';

import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:utils/utils.dart';

class RefreshTokenInterceptor extends QueuedInterceptor {
  final TokenStorage _tokenStorage;
  final AuthWithRefreshTokenUseCase _authWithRefreshTokenUseCase;
  final _innerDio = Dio();
  final void Function() onRefreshTokenExpired;

  RefreshTokenInterceptor(
    this._tokenStorage,
    this._authWithRefreshTokenUseCase,
    this.onRefreshTokenExpired,
  );

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    await _addAuthHeaders(options.headers);
    super.onRequest(options, handler);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      final refreshResult = await _loginWithRefreshToken();
      refreshResult.fold(
        (error) {
          if (error is InvalidRefreshTokenError) {
            handler.reject(err);
            onRefreshTokenExpired();
          } else {
            super.onError(err, handler);
          }
        },
        (_) async {
          try {
            await _addAuthHeaders(err.requestOptions.headers);
            final newResponse = await _innerDio.fetch(err.requestOptions);
            handler.resolve(newResponse);
          } catch (e) {
            super.onError(err, handler);
          }
        },
      );
    } else {
      super.onError(err, handler);
    }
  }

  Future<Either<BaseError, void>> _loginWithRefreshToken() async {
    final res = await _authWithRefreshTokenUseCase();
    return res;
  }

  Future<void> _addAuthHeaders(Map<String, dynamic> headers) async {
    final accessToken = await _tokenStorage.getToken();
    final tokenType = await _tokenStorage.getTokenType();
    if (accessToken == null || tokenType == null) return;
    headers['Authorization'] = '$tokenType $accessToken';
    log('Token: $tokenType $accessToken');
  }
}
