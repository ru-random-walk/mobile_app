import 'package:auth/src/domain/entities/auth_type/enum.dart';
import 'package:auth/src/screens/login/bloc/auth_bloc.dart';
import 'package:auth/src/screens/type_email/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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
    final bloc = context.read<AuthBloc>();
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomButton(
            size: ButtonSize.M,
            leftIcon: Padding(
              padding: EdgeInsets.only(right: 8.toFigmaSize),
              child: SvgPicture.asset('packages/auth/assets/icons/email.svg'),
            ),
            type: ButtonType.secondary,
            text: 'Войти через почту',
            textStyle: context.textTheme.bodyMRegularBase90,
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: bloc,
                  child: const EmailInputPage(),
                ),
              ),
            ),
          ),
          dividerSmall,
          dividerSmall,
          CustomButton(
            size: ButtonSize.M,
            leftIcon: Padding(
              padding: EdgeInsets.only(right: 8.toFigmaSize),
              child: SvgPicture.asset('packages/auth/assets/icons/google.svg'),
            ),
            type: ButtonType.secondary,
            text: 'Войти через Google',
            textStyle: context.textTheme.bodyMRegularBase90,
            onPressed: () => bloc.add(LoginVia(AuthProvider.google)),
          ),
          dividerSmall,
          SizedBox(
            height: 52.toFigmaSize,
          ),
          // CustomButton(
          //   size: ButtonSize.M,
          //   leftIcon: Padding(
          //     padding: EdgeInsets.only(right: 8.toFigmaSize),
          //     child: SvgPicture.asset(
          //       'packages/auth/assets/icons/yandex.svg',
          //     ),
          //   ),
          //   type: ButtonType.secondary,
          //   text: 'Войти через Yandex',
          //   textStyle: context.textTheme.bodyMRegularBase90,
          //   onPressed: () {
          //     log('Pressed');
          //   },
          // ),
          dividerSmall,
          SizedBox(
            height: 52.toFigmaSize,
          ),
          // CustomButton(
          //   size: ButtonSize.M,
          //   leftIcon: Padding(
          //     padding: EdgeInsets.only(right: 8.toFigmaSize),
          //     child: SvgPicture.asset('packages/auth/assets/icons/vk.svg'),
          //   ),
          //   type: ButtonType.secondary,
          //   text: 'Войти через VK',
          //   textStyle: context.textTheme.bodyMRegularBase90,
          //   onPressed: () {
          //     log('Pressed');
          //   },
          // ),
        ],
      ),
    );
  }
}
