import 'dart:async';

import 'package:core/core.dart';
import 'package:matcher_service/src/domain/repository/appointment.dart';
import 'package:utils/utils.dart';

class CancelAppointmentUseCase implements BaseUseCase<BaseError, void, String> {
  final AppointmentRepositoryI _appointmentRepository;

  CancelAppointmentUseCase(this._appointmentRepository);

  @override
  Future<Either<BaseError, void>> call(String id) =>
      _appointmentRepository.cancelAppointment(id);
}
