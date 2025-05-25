import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
