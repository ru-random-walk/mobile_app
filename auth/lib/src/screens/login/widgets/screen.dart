import 'package:auth/auth.dart';
import 'package:auth/src/screens/login/bloc/auth_bloc.dart';
import 'package:auth/src/screens/login/widgets/background.dart';
import 'package:auth/src/screens/login/widgets/button_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/main.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileBloc>();
    final dividerBig = SizedBox(
      height: 40.toFigmaSize,
    );
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        switch (state) {
          case ProfileLoading():
          // TODO: Handle this case.
          case ProfileData():
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => const MainPage(),
              ),
              (_) => false,
            );
          case ProfileError():
          // TODO: Handle this case.
          case ProfileInvalidRefreshToken():
          // TODO: Handle this case.
        }
      },
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('При авторизации произошла ошибка'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          } else if (state is AuthSuccess) {
            bloc.add(ProfileLoadEvent());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: context.colors.main_70,
                content: const Text('Успешная авторизация'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        child: LoginScreenBackground(
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.toFigmaSize),
                child: Column(
                  children: [
                    dividerBig,
                    const AppLogoWithTitle(),
                    dividerBig,
                    const Expanded(
                      child: LoginButtonGroup(),
                    ),
                    SizedBox(
                      height: 100.toFigmaSize,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
