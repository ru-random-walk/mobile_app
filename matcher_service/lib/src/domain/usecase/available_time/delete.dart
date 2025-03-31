import 'package:core/core.dart';
import 'package:matcher_service/src/data/data_source/matcher.dart';
import 'package:matcher_service/src/data/repository/available_time.dart';
import 'package:matcher_service/src/domain/repository/available_time.dart';
import 'package:matcher_service/src/domain/repository/person.dart';
import 'package:utils/utils.dart';

class DeleteAvailableTimeUseCase
    implements BaseUseCase<BaseError, void, String> {
  final AvailableTimeRepositoryI _repository;
  final PersonRepositoryI _personRepository;

  DeleteAvailableTimeUseCase._(
    this._repository,
    this._personRepository,
  );

  factory DeleteAvailableTimeUseCase(PersonRepositoryI personRepository) =>
      DeleteAvailableTimeUseCase._(
        AvailableTimeRepository(
          MatcherDataSource(),
        ),
        personRepository,
      );

  @override
  Future<Either<BaseError, void>> call(String id) async {
    final res = await _repository.deleteAvailableTime(id);
    if (res.isRight) _personRepository.loadUserSchedule();
    return res;
  }
}
