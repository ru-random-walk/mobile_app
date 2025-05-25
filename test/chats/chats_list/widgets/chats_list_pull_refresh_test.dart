import 'package:chats/src/presentation/screens/chat_list/bloc/chats_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_components/ui_components.dart';

import '../fixtures/generate_chats.dart';
import '../fixtures/mocks.dart';
import '../fixtures/pump_screen.dart';
import '../fixtures/test_setup.dart';

void main() {
  late MockChatsListBloc bloc;

  setUpAll(commonSetUpAll);

  setUp(commonsetUp);

  tearDown(commontearDown);

  testWidgets('ChatsListScreen pull to refresh triggers data reload', (tester) async {
    final chats = generateChats(5);
    bloc = mockBlocWithState(ChatsListData(chats: chats)) as MockChatsListBloc;

    await pumpScreen(tester, bloc);
    await tester.pumpAndSettle();

    expect(find.text('Chats'), findsOneWidget);
    expect(find.byType(DialogWidget), findsNWidgets(chats.length));
    for (var i = 0; i < chats.length; i++) {
      expect(find.text('User $i'), findsOneWidget);
    }

    await tester.drag(find.byType(Scrollable).first, const Offset(0, 300));
    await tester.pump();
    expect(find.byType(RefreshProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();

    expect(find.text('Chats'), findsOneWidget);
    expect(find.byType(DialogWidget), findsNWidgets(chats.length));
    for (var i = 0; i < chats.length; i++) {
      expect(find.text('User $i'), findsOneWidget);
    }
  });
}
