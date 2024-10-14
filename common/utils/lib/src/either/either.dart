part 'left.dart';
part 'right.dart';

sealed class Either<L,R>{
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight);

  bool get isRight => this is Right<L,R>;
  bool get isLeft => this is Left<L,R>;
}