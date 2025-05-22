import 'package:auth/src/data/data_source/token.dart';
import 'package:auth/src/data/repositories/auth.dart';
import 'package:auth/src/data/repositories/google_sign_in.dart';
import 'package:auth/src/domain/usecases/email_otp_auth.dart';
import 'package:auth/src/domain/usecases/google_auth.dart';
import 'package:auth/src/domain/usecases/google_sign_in.dart';
import 'package:auth/src/domain/usecases/send_email_otp.dart';
import 'package:auth/src/screens/login/bloc/auth_bloc.dart';
import 'package:auth/src/screens/login/widgets/screen.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final authUseCase = GoogleAuthUseCase(
    GetGoogleAccessTokenUseCase(
      GoogleSignInRepositoryI(),
    ),
    AuthRepositoryI(
      AuthDataSource(NetworkConfig.instance.dio),
    ),
    TokenStorage(),
  );

  final authEmailUseCase = EmailOTPAuthUseCase(
    AuthRepositoryI(
      AuthDataSource(NetworkConfig.instance.dio),
    ),
    TokenStorage(),
  );

  final sendEmailOtp = SendEmailOTPUseCase(
    AuthRepositoryI(
      AuthDataSource(NetworkConfig.instance.dio),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(
        authUseCase,
        authEmailUseCase,
        sendEmailOtp,
      ),
      child: const AuthScreen(),
    );
  }
}
