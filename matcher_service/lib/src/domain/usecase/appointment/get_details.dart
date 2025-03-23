import 'dart:async';

import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:matcher_service/src/data/data_source/matcher.dart';
import 'package:matcher_service/src/data/repository/appointment.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/base.dart';
import 'package:matcher_service/src/domain/repository/appointment.dart';
import 'package:utils/utils.dart';

class GetAppointmentDetailsUseCase
    implements BaseUseCase<BaseError, AppointmentEntity, String> {
  final AppointmentRepositoryI _appointmentRepository;
  final String currentUserId;

  GetAppointmentDetailsUseCase._(
      {required AppointmentRepositoryI appointmentRepository,
      required this.currentUserId})
      : _appointmentRepository = appointmentRepository;

  factory GetAppointmentDetailsUseCase(String userId) {
    return GetAppointmentDetailsUseCase._(
      appointmentRepository: AppointmentRepository(
        matcherDataSource: MatcherDataSource(),
        usersDataSource: UsersDataSource(),
      ),
      currentUserId: userId,
    );
  }

  @override
  Future<Either<BaseError, AppointmentEntity>> call(String id) =>
      _appointmentRepository.getAppointmentDetails(id, currentUserId);
}
