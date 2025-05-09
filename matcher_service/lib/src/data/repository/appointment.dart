import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:matcher_service/src/data/data_source/matcher.dart';
import 'package:matcher_service/src/data/mapper/appointment.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/base.dart';
import 'package:matcher_service/src/domain/repository/appointment.dart';
import 'package:retrofit/retrofit.dart';
import 'package:utils/utils.dart';

class AppointmentRepository implements AppointmentRepositoryI {
  final MatcherDataSource _matcherDataSource;
  final UsersDataSource _usersDataSource;
  final GeocoderDataSource _geocoderDataSource;

  AppointmentRepository({
    required MatcherDataSource matcherDataSource,
    required UsersDataSource usersDataSource,
    required GeocoderDataSource geocoderDataSource,
  })  : _matcherDataSource = matcherDataSource,
        _usersDataSource = usersDataSource,
        _geocoderDataSource = geocoderDataSource;

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
      final geolocationWithName =
          await _geocoderDataSource.getGeolocationByPoint(
        GeocoderQueryModel(
          latitude: appointmentModel.latitude,
          longitude: appointmentModel.longitude,
        ),
      );
      final geolocation = Geolocation(
        latitude: appointmentModel.latitude,
        longitude: appointmentModel.longitude,
        city: geolocationWithName.city,
        street: geolocationWithName.street,
        building: geolocationWithName.building,
      );
      return Right(
        appointmentModel.toEntity(
          partnerModel.content.first,
          geolocation,
        ),
      );
    } catch (e, s) {
      return Left(BaseError(e.toString(), s));
    }
  }

  @override
  Future<Either<BaseError, void>> cancelAppointment(String id) =>
      _performSimpleRequest(() => _matcherDataSource.cancelAppointment(id));

  @override
  Future<Either<BaseError, void>> approveAppointmentRequest(String id) =>
      _performSimpleRequest(
          () => _matcherDataSource.approveAppointmentRequest(id));

  @override
  Future<Either<BaseError, void>> rejectAppointmentRequest(String id) =>
      _performSimpleRequest(
          () => _matcherDataSource.rejectAppointmentRequest(id));

  Future<Either<BaseError, void>> _performSimpleRequest(
      Future<HttpResponse> Function() fetch) async {
    try {
      final res = await fetch();
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
