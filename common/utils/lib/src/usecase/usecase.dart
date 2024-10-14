import 'package:utils/src/either/either.dart';

abstract interface class BaseUseCase<Result, Error, Params> {
  Either<Result, Error> call([Params params]);
}
