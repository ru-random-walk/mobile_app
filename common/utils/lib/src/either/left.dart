part of 'either.dart';

class Left<L, R> extends Either<L, R> {
  final L _value;

  Left(this._value);

  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifLeft(_value);
}
