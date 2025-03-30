import 'dart:async';

import 'package:core/core.dart';
import 'package:matcher_service/src/domain/entity/available_time/modify.dart';
import 'package:matcher_service/src/domain/repository/available_time.dart';
import 'package:utils/utils.dart';

class UpdateAvailableTimeArgs {
  final String id;
  final AvailableTimeModifyEntity modifyEntity;

  UpdateAvailableTimeArgs({
    required this.id,
    required this.modifyEntity,
  });
}

class UpdateAvailableTimeUseCase
    implements BaseUseCase<BaseError, void, UpdateAvailableTimeArgs> {
  final AvailableTimeRepositoryI _repository;

  UpdateAvailableTimeUseCase(this._repository);

  @override
  Future<Either<BaseError, void>> call(UpdateAvailableTimeArgs params) async =>
      _repository.updateAvailableTime(params.id, params.modifyEntity);
}
