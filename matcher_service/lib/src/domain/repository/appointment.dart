import 'package:core/core.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/base.dart';
import 'package:utils/utils.dart';

abstract interface class AppointmentRepositoryI {
  Future<Either<BaseError, AppointmentEntity>> getAppointmentDetails(
    String id,
    String currentUserId,
  );

  Future<Either<BaseError, void>> cancelAppointment(String id);
}
