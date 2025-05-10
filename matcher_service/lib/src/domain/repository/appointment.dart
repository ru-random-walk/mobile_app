import 'package:core/core.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/base.dart';
import 'package:utils/utils.dart';

abstract interface class AppointmentRepositoryI {
  Future<Either<BaseError, AppointmentEntity>> getAppointmentDetails(
    String id,
    String currentUserId,
  );

  Future<Either<BaseError, void>> cancelAppointment(String id);

  Future<Either<BaseError, void>> rejectAppointmentRequest(String id);

  Future<Either<BaseError, void>> approveAppointmentRequest(String id);
}
