import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:core/core.dart';

class ClubApiService {
  final Dio httpClient = Dio();
  final dioClient = NetworkConfig.instance.dio;

  final String url = 'https://random-walk.ru:44424/clubs';
  final Logger logger = Logger();

  Future<Map<String, dynamic>?> createClub(String name) async {
    try {
      final response = await httpClient.post(
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
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );

      if (response.statusCode == 200 && response.data['data'] != null) {
        return response.data['data']['createClub'];
      } else {
        logger.e('Ошибка при создании клуба: ${response.data}');
        return null;
      }
    } catch (e, stackTrace) {
      logger.e('Ошибка при выполнении запроса', error: e, stackTrace: stackTrace);
      return null;
    }
  }
}
