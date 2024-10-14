import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';

class LoginButtonGroup extends StatelessWidget {
  const LoginButtonGroup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dividerSmall = SizedBox(
      height: 16.toFigmaSize,
    );
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomButton(
            size: ButtonSize.M,
            leftIcon: Padding(
              padding: EdgeInsets.only(right: 8.toFigmaSize),
              child: SvgPicture.asset('packages/auth/assets/icons/google.svg'),
            ),
            type: ButtonType.secondary,
            text: 'Войти через Google',
            textStyle: context.textTheme.bodyMRegularBase90,
            onPressed: () async {
              final scopes = [
                'https://www.googleapis.com/auth/userinfo.email',
                'https://www.googleapis.com/auth/userinfo.profile',
              ];
              final gogleSignIn = GoogleSignIn(
                scopes: scopes,
              );
              try {
                final acc = await gogleSignIn.signIn();
                final auth = await acc?.authentication;
                final idToken = auth?.idToken;
                final token = auth?.accessToken;
                print(token);
              } catch (e, s) {
                print(e);
                print(s);
              }
              print('Pressed');
            },
          ),
          dividerSmall,
          CustomButton(
            size: ButtonSize.M,
            leftIcon: Padding(
              padding: EdgeInsets.only(right: 8.toFigmaSize),
              child: SvgPicture.asset(
                'packages/auth/assets/icons/yandex.svg',
              ),
            ),
            type: ButtonType.secondary,
            text: 'Войти через Yandex',
            textStyle: context.textTheme.bodyMRegularBase90,
            onPressed: () {
              print('Pressed');
            },
          ),
          dividerSmall,
          CustomButton(
            size: ButtonSize.M,
            leftIcon: Padding(
              padding: EdgeInsets.only(right: 8.toFigmaSize),
              child: SvgPicture.asset('packages/auth/assets/icons/vk.svg'),
            ),
            type: ButtonType.secondary,
            text: 'Войти через VK',
            textStyle: context.textTheme.bodyMRegularBase90,
            onPressed: () {
              print('Pressed');
            },
          ),
        ],
      ),
    );
  }
}
