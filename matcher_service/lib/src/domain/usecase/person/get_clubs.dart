import 'dart:async';

import 'package:clubs/clubs.dart';
import 'package:core/core.dart';
import 'package:matcher_service/src/data/repository/person.dart';
import 'package:utils/utils.dart';

class GetPersonClubsUseCase
    implements BaseUseCase<BaseError, List<ShortClubEntity>, String> {
  final PersonRepository _personRepository;

  GetPersonClubsUseCase(this._personRepository);

  @override
  Future<Either<BaseError, List<ShortClubEntity>>> call(String userId) =>
      _personRepository.getCurrentUserClubs(userId);
}
