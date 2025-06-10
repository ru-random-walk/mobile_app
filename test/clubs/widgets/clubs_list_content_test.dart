import 'package:chats/src/presentation/screens/chat_list/bloc/chats_list_bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';

import '../fixtures/generate_clubs.dart';
import '../fixtures/mocks.dart';
import '../fixtures/pump_screen.dart';
import '../fixtures/test_setup.dart';

void main() {
  late MockClubsListBloc bloc;

  setUpAll(commonSetUpAll);

  setUp(commonsetUp);

  tearDown(commontearDown);

  testWidgets('Clubs List Screen - clubs list', (WidgetTester tester) async {
    final clubs = generateClubs(3);
    bloc = mockBlocWithState(ChatsListData(chats: clubs)) as MockClubsListBloc;

    await pumpScreen(tester, bloc); 
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(Row), findsWidgets);
    expect(find.byType(DialogWidget), findsNWidgets(3));
    for (var i = 0; i < clubs.length; i++) {
      expect(find.text('User $i'), findsOneWidget);
      expect(find.text('Test message $i'), findsOneWidget);
    }
  });

  testWidgets('Chats List Screen - empty state', (WidgetTester tester) async {
    bloc = mockBlocWithState(ChatsListEmpty()) as MockClubsListBloc;

    await pumpScreen(tester, bloc);

    expect(find.byType(Row), findsWidgets);
      
    final finder = find.byWidgetPredicate((widget) {
      if (widget is Image && widget.image is AssetImage) {
        final assetImage = widget.image as AssetImage;
        final matchesPath = assetImage.assetName == 'packages/chats/assets/images/no_chats.png';
        final matchesHeight = widget.height == 160.toFigmaSize;
        final matchesWidth = widget.width == 200.toFigmaSize;
        return matchesPath && matchesHeight && matchesWidth;
      }
      return false;
    });

    expect(finder, findsOneWidget);
  });

  testWidgets('Clubs List Screen - loading state', (WidgetTester tester) async {
    bloc = mockBlocWithState(ChatsListLoading()) as MockClubsListBloc;

    await pumpScreen(tester, bloc);
    await tester.pump(const Duration(milliseconds: 100)); 

    expect(find.byType(Row), findsWidgets);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Chats List Screen - error state', (WidgetTester tester) async {
    bloc = mockBlocWithState(ChatsListError
      (error: BaseError('error', null)),) as MockClubsListBloc;

    await pumpScreen(tester, bloc);

    expect(find.byType(Row), findsWidgets);
    expect(find.text('Что-то пошло не так'), findsOneWidget);
  });
}
