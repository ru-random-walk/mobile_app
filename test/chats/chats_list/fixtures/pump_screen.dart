import 'package:auth/auth.dart';
import 'package:chats/chats.dart';
import 'package:chats/src/presentation/screens/chat_list/bloc/chats_list_bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:provider/provider.dart';

import '../../../helpers/build_light_theme.dart';
import 'mocks.dart';
import 'test_app_database.dart';

Future<void> pumpScreen(WidgetTester tester, MockChatsListBloc bloc) async {
  final mockTokenStorage = MockTokenStorage();
  final mockGetProfileUseCase = getMockGetProfileUseCase();

  await mockNetworkImagesFor(() async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<GetProfileUseCase>.value(value: mockGetProfileUseCase),
          Provider<AppDatabase>.value(value: TestAppDatabase.instance),
          Provider<TokenStorage>.value(value: mockTokenStorage),      
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => ProfileBloc(
                context.read<GetProfileUseCase>(),
                context.read<TokenStorage>(),    
              ),
            ),
            BlocProvider<ChatsListBloc>.value(value: bloc),
          ],
          child: MaterialApp(
            theme: buildLightTheme(),
            home: const ChatsListScreen(currentUserId: 'user_test1'),
          ),
        ),
      ),  
    );
    await tester.pump();
  });
}
