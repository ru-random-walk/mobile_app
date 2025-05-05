import 'dart:async';

import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:matcher_service/src/data/data_source/matcher.dart';
import 'package:matcher_service/src/data/repository/appointment.dart';
import 'package:matcher_service/src/domain/repository/appointment.dart';
import 'package:matcher_service/src/domain/repository/person.dart';
import 'package:utils/utils.dart';

class CancelAppointmentUseCase implements BaseUseCase<BaseError, void, String> {
  final AppointmentRepositoryI _appointmentRepository;
  final PersonRepositoryI _personRepository;

  CancelAppointmentUseCase._(
    this._appointmentRepository,
    this._personRepository,
  );

  factory CancelAppointmentUseCase(PersonRepositoryI personRepository) =>
      CancelAppointmentUseCase._(
        AppointmentRepository(
          matcherDataSource: MatcherDataSource(),
          usersDataSource: UsersDataSource(),
          geocoderDataSource: GeocoderDataSource(),
        ),
        personRepository,
      );

  @override
  Future<Either<BaseError, void>> call(String id) async {
    final res = await _appointmentRepository.cancelAppointment(id);
    if (res.isRight) _personRepository.loadUserSchedule();
    return res;
  }
}
