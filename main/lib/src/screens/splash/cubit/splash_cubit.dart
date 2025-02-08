import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final _tokenStorage = TokenStorage(); 

  SplashCubit() : super(SplashInitial());

  Future<void> checkAuth() async {
    final token = await _tokenStorage.getToken();
    if (token == null) {
      emit(Unauthenticated());
    } else {
      emit(Authenticated());
    }
  }
}
