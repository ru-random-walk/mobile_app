import 'package:core/core.dart';
import 'package:matcher_service/src/domain/repository/available_time.dart';
import 'package:utils/utils.dart';

class DeleteAvailableTimeUseCase
    implements BaseUseCase<BaseError, void, String> {
  final AvailableTimeRepositoryI _repository;

  DeleteAvailableTimeUseCase(this._repository);

  @override
  Future<Either<BaseError, void>> call(String id) async =>
      _repository.deleteAvailableTime(id);
}
