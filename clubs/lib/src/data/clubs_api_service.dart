import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'error_handler.dart';
import 'package:core/core.dart';

part 'create_clubs/create_club_free.dart';
part 'create_clubs/create_club_confirm.dart';
part 'create_clubs/create_club_test.dart';
part 'remove_clubs/remove_club.dart';
part 'get_clubs/get_id_clubs.dart';
part 'get_clubs/get_clubs_info.dart';
part 'get_clubs/get_members_club.dart';
part 'get_clubs/get_approvement_info.dart';
part 'change_member_role/change_member_role.dart';
part 'change_member_role/remove_member.dart';

class ClubApiService {
  final dioClient = NetworkConfig.instance.dio;
  final String url = '/club/graphql';
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

      final responseData = <String, dynamic>{
      'data': response.data['data'],
      'errors': response.data['errors'],
    };
      if (response.statusCode == 200) {
        logger.i('Response Data: ${response.data}');
      }
      return responseData;
    } on DioException catch (e, stackTrace) {
      handleError(e, stackTrace: stackTrace);
      return {'data': null, 'errors': [e.toString()]};
    } catch (e, stackTrace) {
      handleError(e, stackTrace: stackTrace);
      return {'data': null, 'errors': [e.toString()]};
    }
  }
}
