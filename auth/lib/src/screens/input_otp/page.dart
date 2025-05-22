import 'dart:async';
import 'dart:developer';

import 'package:auth/src/screens/login/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';

class EmailOTPInputPage extends StatefulWidget {
  final String email;

  const EmailOTPInputPage({super.key, required this.email});

  @override
  State<EmailOTPInputPage> createState() => _EmailOTPInputPageState();
}

class _EmailOTPInputPageState extends State<EmailOTPInputPage> {
  final secondsToResendNotifier = ValueNotifier(60);
  final secondsToResend = 60;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    setTimerToResend();
  }

  void setTimerToResend() {
    secondsToResendNotifier.value = secondsToResend;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      secondsToResendNotifier.value--;
      if (secondsToResendNotifier.value == 0) {
        timer.cancel();
      }
    });
  }

  void tryToAuth(String otp) {
    log('Try to auth with $otp');
    final bloc = context.read<AuthBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.base_0,
      child: SafeArea(
        child: Scaffold(
          appBar: _AppBar(),
          body: Padding(
            padding: EdgeInsets.all(16.toFigmaSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'На вашу почту ',
                        style: context.textTheme.bodyMRegularBase90,
                      ),
                      TextSpan(
                        text: widget.email,
                        style: context.textTheme.bodyMRegularBase0.copyWith(
                          color: context.colors.main_50,
                        ),
                      ),
                      TextSpan(
                        text:
                            ' было отправлено письмо с 6-значым кодом,  введите его ниже',
                        style: context.textTheme.bodyMRegularBase90,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.toFigmaSize),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.toFigmaSize),
                    child: Pinput(
                      length: 6,
                      onCompleted: tryToAuth,
                      pinAnimationType: PinAnimationType.none,
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      isCursorAnimationEnabled: false,
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      defaultPinTheme: PinTheme(
                        width: 54.toFigmaSize,
                        height: 54.toFigmaSize,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: context.colors.main_80,
                          ),
                          borderRadius: BorderRadius.circular(6.toFigmaSize),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.toFigmaSize,
                ),
                Center(
                  child: Text(
                    'Не получили код?',
                    style: context.textTheme.bodyMRegularBase70,
                  ),
                ),
                SizedBox(
                  height: 16.toFigmaSize,
                ),
                Center(
                  child: ValueListenableBuilder(
                      valueListenable: secondsToResendNotifier,
                      builder: (context, value, child) {
                        final button = CustomButton(
                          type: ButtonType.tertiary,
                          text: 'Отправить еще раз',
                          size: ButtonSize.S,
                          disabled: value != 0,
                          isMaxWidth: false,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.toFigmaSize,
                          ),
                          onPressed: () {
                            setTimerToResend();
                          },
                        );
                        final timer = value > 0
                            ? Text(
                                '00:${value.toString().padLeft(2, '0')}',
                                style:
                                    context.textTheme.bodySMediumBase0.copyWith(
                                  color: context.colors.base_90,
                                ),
                              )
                            : const SizedBox.shrink();
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            button,
                            timer,
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    timer = null;
    secondsToResendNotifier.dispose();
  }
}

final _appBarHeight = 56.toFigmaSize;

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 20.toFigmaSize),
        Icon(
          Icons.arrow_back,
          size: 24.toFigmaSize,
          color: context.colors.base_70,
        ),
        SizedBox(width: 16.toFigmaSize),
        Expanded(
          child: Text(
            'Введите код',
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
