import 'package:chats/src/presentation/screens/chat_list/bloc/chats_list_bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';

import '../fixtures/generate_chats.dart';
import '../fixtures/mocks.dart';
import '../fixtures/pump_screen.dart';
import '../fixtures/test_setup.dart';

void main() {
  late MockChatsListBloc bloc;

  setUpAll(commonSetUpAll);

  setUp(commonsetUp);

  tearDown(commontearDown);

  testWidgets('Chats List Screen - chat list', (WidgetTester tester) async {
    final chats = generateChats(3);
    bloc = mockBlocWithState(ChatsListData(chats: chats)) as MockChatsListBloc;

    await pumpScreen(tester, bloc); 
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Chats'), findsOneWidget);
    expect(find.byType(Row), findsWidgets);
    expect(find.byType(DialogWidget), findsNWidgets(3));
    for (var i = 0; i < chats.length; i++) {
      expect(find.text('User $i'), findsOneWidget);
      expect(find.text('Test message $i'), findsOneWidget);
    }
  });

  testWidgets('Chats List Screen - empty state', (WidgetTester tester) async {
    bloc = mockBlocWithState(ChatsListEmpty()) as MockChatsListBloc;

    await pumpScreen(tester, bloc);

    expect(find.text('Chats'), findsOneWidget);
    expect(find.byType(Row), findsWidgets);
    expect(find.text('Чатов пока нет'), findsOneWidget);
    expect(find.text('Ваши чаты появятся здесь поле назначения прогулки'), 
      findsOneWidget,);
      
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

  testWidgets('Chats List Screen - loading state', (WidgetTester tester) async {
    bloc = mockBlocWithState(ChatsListLoading()) as MockChatsListBloc;

    await pumpScreen(tester, bloc);
    await tester.pump(const Duration(milliseconds: 100)); 

    expect(find.text('Chats'), findsOneWidget);
    expect(find.byType(Row), findsWidgets);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Chats List Screen - error message', (WidgetTester tester) async {
    bloc = mockBlocWithState(ChatsListError
      (error: BaseError('error', null)),) as MockChatsListBloc;

    await pumpScreen(tester, bloc);

    expect(find.text('Chats'), findsOneWidget);
    expect(find.byType(Row), findsWidgets);
    expect(find.text('Что-то пошло не так'), findsOneWidget);
  });
}
