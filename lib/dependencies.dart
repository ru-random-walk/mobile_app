import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:provider/provider.dart';

final providersScope = <Provider>[
  Provider<GetProfileUseCase>(create: (_) => GetProfileUseCase()),
  Provider<AppDatabase>(create: (_) => AppDatabase()),
];
