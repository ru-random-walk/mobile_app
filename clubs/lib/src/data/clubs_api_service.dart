import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'error_handler.dart';
import 'package:core/core.dart';

part 'create_clubs/create_club_free.dart';
part 'create_clubs/create_club_confirm.dart';
part 'create_clubs/create_club_test.dart';
part 'remove_clubs/remove_club.dart';
part 'get_clubs/get_id_clubs.dart';

class ClubApiService {
  final dioClient = NetworkConfig.instance.dio;
  final String url = 'https://random-walk.ru:44424/club/graphql';
  final Logger logger = Logger();

  Future<Map<String, dynamic>?> performPostRequest(String query, Map<String, dynamic> variables) async {
    try {
      final response = await dioClient.post(
        url,
        data: {
          'query': query,
          'variables': variables,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['data'] != null) {
        logger.i('Response Data: ${response.data}');
        return response.data['data'];
      } else {
        handleError(response);
        return null;
      }
    } on DioException catch (e, stackTrace) {
      handleError(e, stackTrace: stackTrace);
      return null;
    } catch (e, stackTrace) {
      handleError(e, stackTrace: stackTrace);
      return null;
    }
  }
}
