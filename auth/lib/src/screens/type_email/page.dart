import 'package:auth/src/screens/input_otp/page.dart';
import 'package:auth/src/screens/login/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';

class EmailInputPage extends StatefulWidget {
  const EmailInputPage({super.key});

  @override
  State<EmailInputPage> createState() => _EmailInputPageState();
}

class _EmailInputPageState extends State<EmailInputPage> {
  final emailController = TextEditingController();
  final canProceedNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    emailController.addListener(_validateEmail);
  }

  void _validateEmail() {
    final email = emailController.text;
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    canProceedNotifier.value = emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SendOTPSuccess) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: context.read<AuthBloc>(),
                child: EmailOTPInputPage(
                  email: emailController.text,
                ),
              ),
            ),
          );
        } else if (state is SendOTPFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Не удалось отправить код подтверждения'),
            ),
          );
        }
      },
      child: ColoredBox(
        color: context.colors.base_0,
        child: SafeArea(
          child: Scaffold(
            appBar: _AppBar(),
            body: Padding(
              padding: EdgeInsets.all(16.toFigmaSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Введите свою почту, а мы отправим вам письмо с кодом подтверждения',
                    style: context.textTheme.bodyMRegularBase90,
                  ),
                  SizedBox(height: 16.toFigmaSize),
                  Text(
                    'Ваша почта',
                    style: context.textTheme.captionRegular.copyWith(
                      color: context.colors.base_40,
                    ),
                  ),
                  SizedBox(height: 4.toFigmaSize),
                  TextField(
                    controller: emailController,
                    style: context.textTheme.bodyMRegularBase90,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: context.colors.main_80),
                        borderRadius: BorderRadius.circular(6.toFigmaSize),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: context.colors.main_80),
                        borderRadius: BorderRadius.circular(6.toFigmaSize),
                      ),
                      contentPadding: EdgeInsets.all(12.toFigmaSize),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const Spacer(),
                  ValueListenableBuilder(
                    valueListenable: canProceedNotifier,
                    builder: (context, value, _) {
                      return CustomButton(
                        disabled: !value,
                        text: 'Отправить код',
                        size: ButtonSize.M,
                        onPressed: () => context.read<AuthBloc>().add(
                              SendEmailOtp(
                                emailController.text,
                              ),
                            ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.removeListener(_validateEmail);
    emailController.dispose();
  }
}

final _appBarHeight = 56.toFigmaSize;

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 20.toFigmaSize),
        GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.arrow_back,
            size: 24.toFigmaSize,
            color: context.colors.base_70,
          ),
        ),
        SizedBox(width: 16.toFigmaSize),
        Expanded(
          child: Text(
            'Введите почту',
            style: context.textTheme.h4.copyWith(
              color: context.colors.base_90,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_appBarHeight);
}
