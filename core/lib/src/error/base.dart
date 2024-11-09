class BaseError implements Exception {
  final String message;

  final StackTrace? stackTrace;

  BaseError(this.message, this.stackTrace);
}
