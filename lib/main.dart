import 'dart:io';

import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/main.dart';
import 'package:provider/provider.dart';
import 'package:ui_theming/ui_theming.dart';

import 'dependencies.dart';
import 'firebase_options.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await EnvironmentVariables.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const Padding(
      padding: EdgeInsets.only(
        bottom: kIsWeb ? 25 : 0,
      ),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return MultiProvider(
      providers: providersScope,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProfileBloc(
              context.read(),
              TokenStorage(),
            ),
          ),
        ],
        child: MaterialApp(
          theme: lightTheme,
          home: const SplashPage(),
        ),
      ),
    );
  }
}
