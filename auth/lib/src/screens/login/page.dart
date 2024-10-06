import 'package:auth/src/screens/login/widgets/background.dart';
import 'package:auth/src/screens/login/widgets/button_group.dart';
import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dividerBig = SizedBox(
      height: 40.toFigmaSize,
    );
    return LoginScreenBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.toFigmaSize),
          child: Column(
            children: [
              dividerBig,
              dividerBig,
              const AppLogoWithTitle(),
              dividerBig,
              const Expanded(
                child: LoginButtonGroup(),
              ),
              dividerBig,
              dividerBig,
            ],
          ),
        ),
      ),
    );
  }
}
