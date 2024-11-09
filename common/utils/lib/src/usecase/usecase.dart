import 'dart:async';

import 'package:utils/src/either/either.dart';

abstract interface class BaseUseCase<Error, Result, Params> {
  FutureOr<Either<Error, Result>> call(Params params);
}
