part of 'either.dart';

class Right<L, R> extends Either<L, R> {
  final R _value;

  Right(this._value);

  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifRight(_value);
}