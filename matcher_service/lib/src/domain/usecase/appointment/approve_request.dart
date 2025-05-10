import 'dart:async';

import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:matcher_service/src/data/data_source/matcher.dart';
import 'package:matcher_service/src/data/repository/appointment.dart';
import 'package:matcher_service/src/domain/repository/appointment.dart';
import 'package:utils/utils.dart';

class ApproveAppointmentRequestUseCase
    implements BaseUseCase<BaseError, void, String> {
  final AppointmentRepositoryI _appointmentRepository;

  ApproveAppointmentRequestUseCase._(this._appointmentRepository);

  factory ApproveAppointmentRequestUseCase() =>
      ApproveAppointmentRequestUseCase._(
        AppointmentRepository(
          matcherDataSource: MatcherDataSource(),
          usersDataSource: UsersDataSource(),
          geocoderDataSource: GeocoderDataSource(),
        ),
      );

  @override
  FutureOr<Either<BaseError, void>> call(String id) =>
      _appointmentRepository.approveAppointmentRequest(id);
}
