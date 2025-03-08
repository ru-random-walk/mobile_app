import 'package:core/core.dart';

class InvalidRefreshTokenError extends BaseError {
  InvalidRefreshTokenError(StackTrace? stackTrace)
      : super('Invalid refresh token', stackTrace);
}
