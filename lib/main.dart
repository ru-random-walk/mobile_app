import 'package:auth/auth.dart';
import 'package:chats/chats.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:main/main.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_theming/ui_theming.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
    return const MainPage(
      pages: [
        Center(
          child: Text('1'),
        ),
        Center(
          child: Text('2'),
        ),
        ChatsListPage(),
        Center(
          child: Text('4'),
        ),
      ],
    );
  }
}
