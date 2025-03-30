import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:matcher_service/src/data/data_source/matcher.dart';
import 'package:matcher_service/src/data/mapper/appointment.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/base.dart';
import 'package:matcher_service/src/domain/repository/appointment.dart';
import 'package:utils/utils.dart';

class AppointmentRepository implements AppointmentRepositoryI {
  final MatcherDataSource _matcherDataSource;
  final UsersDataSource _usersDataSource;

  AppointmentRepository({
    required MatcherDataSource matcherDataSource,
    required UsersDataSource usersDataSource,
  })  : _matcherDataSource = matcherDataSource,
        _usersDataSource = usersDataSource;

  @override
  Future<Either<BaseError, AppointmentEntity>> getAppointmentDetails(
    String id,
    String currentUserId,
  ) async {
    try {
      final appointmentModel =
          await _matcherDataSource.getAppointmentDetails(id);
      final partnerId =
          appointmentModel.participants.firstWhere((e) => e != currentUserId);
      final partnerModel = await _usersDataSource.getUsers(
        PageQueryModel(page: 0, size: 1),
        [partnerId],
      );
      return Right(
        appointmentModel.toEntity(
          partnerModel.content.first,
        ),
      );
    } catch (e, s) {
      return Left(BaseError(e.toString(), s));
    }
  }

  @override
  Future<Either<BaseError, void>> cancelAppointment(String id) async {
    try {
      final res = await _matcherDataSource.cancelAppointment(id);
      if (res.response.statusCode == 200) {
        return Right(null);
      } else {
        return Left(BaseError(res.response.data, null));
      }
    } catch (e, s) {
      return Left(BaseError(e.toString(), s));
    }
  }
}
