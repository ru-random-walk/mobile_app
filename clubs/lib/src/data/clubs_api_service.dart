import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
part 'change_member_role/remove_member_from_club.dart';
part 'change_member_role/add_member_in_club.dart';
part 'answers/create_answer_form.dart';
part 'join_in_club/send_answers.dart';
part 'join_in_club/send_answers_sync.dart';
part 'search_clubs/search_clubs.dart';
part 'approver_confirmations/get_approver_waiting_confirmation.dart';
part 'approver_confirmations/approve_confirmation.dart';
part 'approver_confirmations/reject_confirmation.dart';
part 'join_in_club/join_in_club.dart';
part 'answers/create_answer_members_confirm.dart';
part 'club_approvements/add_members_confirm.dart';
part 'club_approvements/add_test_form.dart';
part 'club_approvements/update_members_confirm.dart';
part 'club_approvements/update_test_form.dart';
part 'club_approvements/remove_approvement.dart';

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
