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
  static const _appointmentId = '$_appointment/{id}';

  /// Available time
  @POST('$_avaialableTimePrefix/add')
  @Headers({'Content-Type': 'application/json'})
  Future<HttpResponse> addAvailableTime(
    @Body() AvailabelTimeModel availabelTimeModel,
  );

  @PUT('$_avaialableTimePrefix/{id}/change')
  @Headers({'Content-Type': 'application/json'})
  Future<HttpResponse> updateAvailableTime(
    @Path('id') String id,
    @Body() AvailabelTimeModel availabelTimeModel,
  );

  @DELETE('$_avaialableTimePrefix/{id}')
  Future<HttpResponse> deleteAvailableTime(
    @Path('id') String id,
  );

  /// Person
  @GET('$_person/schedule')
  Future<List<UserScheduleModel>> getUserSchedule();

  /// Appointment
  @GET(_appointmentId)
  Future<AppointmentDetailsModel> getAppointmentDetails(
    @Path('id') String id,
  );

  @DELETE('$_appointmentId/cancel')
  Future<HttpResponse> cancelAppointment(
    @Path('id') String id,
  );

  @PUT('$_appointmentId/reject')
  Future<HttpResponse> rejectAppointmentRequest(
    @Path('id') String id,
  );

  @PUT('$_appointmentId/approve')
  Future<HttpResponse> approveAppointmentRequest(
    @Path('id') String id,
  );
}
