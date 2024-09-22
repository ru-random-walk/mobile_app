import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_theming/ui_theming.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: CustomButton(
            leftIcon: SvgPicture.asset('assets/icons/vk.svg'),
            type: ButtonType.secondary,
            text: 'Test',
            onPressed: () {
              print('Pressed');
            },
          ),
        ),
      ),
    );
  }
}
