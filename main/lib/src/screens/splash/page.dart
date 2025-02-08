import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/main.dart';
import 'package:main/src/screens/main/main_screen.dart';
import 'package:main/src/screens/splash/cubit/splash_cubit.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';

part 'screen.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashCubit>(
      create: (_) => SplashCubit(),
      child: _SplashScreen(),
    );
  }
}
