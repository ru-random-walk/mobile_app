import 'package:auth/src/data/data_source/token.dart';
import 'package:auth/src/data/repositories/auth.dart';
import 'package:auth/src/data/repositories/google_sign_in.dart';
import 'package:auth/src/domain/usecases/auth.dart';
import 'package:auth/src/domain/usecases/google_sign_in.dart';
import 'package:auth/src/screens/bloc/auth_bloc.dart';
import 'package:auth/src/screens/login/widgets/screen.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authUseCase = AuthUseCase(
      GetGoogleAccessTokenUseCase(
        GoogleSignInRepositoryI(),
      ),
      AuthRepositoryI(
        AuthDataSource(NetworkConfig.instance.dio),
      ),
      TokenStorage(),
    );
    return BlocProvider(
      create: (_) => AuthBloc(authUseCase),
      child: const AuthScreen(),
    );
  }
}
