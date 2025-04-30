import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:core/core.dart';

class ClubApiService {
  final dioClient = NetworkConfig.instance.dio;

  final String url = 'https://random-walk.ru:44424/club/graphql';
  final Logger logger = Logger();

  Future<Map<String, dynamic>?> createClub(String name) async {
  try {
    final response = await dioClient.post(
      url,
      data: {
        'query': '''
          mutation createMyClub(\$name: String!) {
            createClub(name: \$name) {
              id
              name
              members {
                id
                role
              }
            }
          }
        ''',
        'variables': {
          'name': name,
        },
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200 && response.data['data'] != null) {
      return response.data['data']['createClub'];
    } else {
      logger.e('Ошибка при создании клуба',
        error: {
          'status': response.statusCode,
          'data': response.data,
          'requestPath': url,
          'headers': response.headers.map,
        },
      );
      return null;
    }
  } on DioException catch (e, stackTrace) {
    logger.e('DioException во время запроса',
      error: {
        'message': e.message,
        'statusCode': e.response?.statusCode,
        'responseData': e.response?.data,
        'requestPath': e.requestOptions.path,
        'requestData': e.requestOptions.data,
        'headers': e.requestOptions.headers,
      },
      stackTrace: stackTrace,
    );
    return null;
  } catch (e, stackTrace) {
    logger.e('Неизвестная ошибка при запросе', error: e, stackTrace: stackTrace);
    return null;
  }
}
}
