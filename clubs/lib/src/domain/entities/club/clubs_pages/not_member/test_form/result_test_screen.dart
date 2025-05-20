import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestResultScreen extends StatelessWidget {
  final bool result;

  const TestResultScreen({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    String title;
    String message;
    String iconPath;
    double size;

    if (result){
      title = 'Тест пройден';
      message = 'Вы отлично справились!\nПродолжайте в том же духе!';
      iconPath = 'packages/clubs/assets/icons/success.svg';
      size = 240.toFigmaSize;
    } else{
      title = 'Тест не пройден';
      message = 'Не расстраивайтесь!\nВ этот раз не удалось, но в следующий будет лучше!';
      iconPath = 'packages/clubs/assets/icons/fail.svg';
      size = 200.toFigmaSize;
    }
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical:16.toFigmaSize,
              horizontal: 24.toFigmaSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Результат',
                  style: context.textTheme.h3.copyWith(
                    color: context.colors.base_90,),
                ),
                SizedBox(height: 20.toFigmaSize),
                SvgPicture.asset(
                  iconPath,
                  width: size,
                  height: size,
                ),
                SizedBox(height: 24.toFigmaSize),
                Text(
                  title,
                  style: context.textTheme.h3.copyWith(
                    color: result ? context.colors.main_60 : const Color(0xFFFF281A)),
                ),
                SizedBox(height: 20.toFigmaSize),
                Text(
                  message,
                  style: context.textTheme.bodyXLRegular.copyWith(
                    color: context.colors.base_90),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.toFigmaSize),
                CustomButton(
                  text: 'Вернуться к группе',
                  customWidth: 200.toFigmaSize,
                  onPressed: () {
                    Navigator.of(context).pop(result);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
