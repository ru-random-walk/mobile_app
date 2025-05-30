part 'left.dart';
part 'right.dart';

sealed class Either<L,R>{
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight);

  bool get isRight => this is Right<L,R>;
  bool get isLeft => this is Left<L,R>;

  L get leftValue => (this as Left<L,R>)._value;
  R get rightValue => (this as Right<L,R>)._value;
}