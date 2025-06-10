import 'package:chats/src/presentation/screens/chat_list/bloc/chats_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_components/ui_components.dart';

import '../fixtures/generate_clubs.dart';
import '../fixtures/mocks.dart';
import '../fixtures/pump_screen.dart';
import '../fixtures/test_setup.dart';

void main() {
  late MockClubsListBloc bloc;

  setUpAll(commonSetUpAll);

  setUp(commonsetUp);

  tearDown(commontearDown);

  testWidgets('ClubsListScreen pull to refresh triggers data reload', 
      (tester) async {
    final chats = generateClubs(5);
    bloc = mockBlocWithState(ChatsListData(chats: chats)) as MockClubsListBloc;

    await pumpScreen(tester, bloc);
    await tester.pumpAndSettle();

    expect(find.byType(DialogWidget), findsNWidgets(chats.length));
    for (var i = 0; i < chats.length; i++) {
      expect(find.text('User $i'), findsOneWidget);
    }

    await tester.drag(find.byType(Scrollable).first, const Offset(0, 300));
    await tester.pump();
    expect(find.byType(RefreshProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle();

    expect(find.byType(DialogWidget), findsNWidgets(chats.length));
    for (var i = 0; i < chats.length; i++) {
      expect(find.text('User $i'), findsOneWidget);
    }
  });
}
