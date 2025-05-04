import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

void handleError(dynamic error, {StackTrace? stackTrace}) {
  final logger = Logger();

  if (error is DioException) {
    logger.e('DioException при запросе',
      error: {
        'message': error.message,
        'statusCode': error.response?.statusCode,
        'responseData': error.response?.data,
        'requestPath': error.requestOptions.path,
        'requestData': error.requestOptions.data,
        'headers': error.requestOptions.headers,
      },
      stackTrace: stackTrace,
    );
  } else {
    logger.e('Неизвестная ошибка при запросе', error: error, stackTrace: stackTrace);
  }
}
