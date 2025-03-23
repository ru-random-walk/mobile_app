import 'package:core/core.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:matcher_service/src/data/model/appointment.dart';
import 'package:matcher_service/src/data/model/schedule/user_schedule.dart';
import 'package:retrofit/retrofit.dart';

import '../model/availabel_time.dart';

part 'matcher.g.dart';

@RestApi()
abstract class MatcherDataSource {
  factory MatcherDataSource() => _MatcherDataSource(NetworkConfig.instance.dio);

  static const _prefix = '/matcher';
  static const _avaialableTimePrefix = '$_prefix/available-time';
  static const _person = '$_prefix/person';
  static const _appointment = '$_prefix/appointment';

  @POST('$_avaialableTimePrefix/add')
  @Headers({'Content-Type': 'application/json'})
  Future<HttpResponse> addAvailableTime(
    @Body() AvailabelTimeModel availabelTimeModel,
  );

  @GET('$_person/schedule')
  Future<List<UserScheduleModel>> getUserSchedule();

  @GET('$_appointment/{id}')
  Future<AppointmentDetailsModel> getAppointmentDetails(@Path('id') String id);
}
