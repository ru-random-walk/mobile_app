// ignore_for_file: deprecated_member_use

import 'package:chats/src/presentation/screens/chat_list/bloc/chats_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_components/ui_components.dart';

import '../fixtures/generate_matcher.dart';
import '../fixtures/mocks.dart';
import '../fixtures/pump_screen.dart';
import '../fixtures/test_setup.dart';

void main() {
  late MockMatcherBloc bloc;

  setUpAll(commonSetUpAll);

  setUp(commonsetUp);

  tearDown(commontearDown);

  testWidgets('MatcherScreen - layout does not overflow or overlap',
     (WidgetTester tester) async {
    final chats = generateMatcher(5);
    bloc = mockBlocWithState(ChatsListData(chats: chats)) as MockMatcherBloc;

    await pumpScreen(tester, bloc);
    await tester.pump(const Duration(milliseconds: 100)); 

    expect(tester.takeException(), isNull);
    final dialogWidgets = find.byType(DialogWidget);
    expect(dialogWidgets, findsNWidgets(chats.length));

    final screenSize = tester.binding.window.physicalSize 
      / tester.binding.window.devicePixelRatio;

    for (var i = 0; i < chats.length; i++) {
      final dialog = dialogWidgets.at(i);
      final rect = tester.getRect(dialog);

      expect(rect.left >= 0, true);
      expect(rect.right <= screenSize.width, true);
      expect(rect.top >= 0, true);
      expect(rect.bottom <= screenSize.height, true);
    }
  });

  testWidgets('MatcherScreen - empty state layout is correct', 
      (WidgetTester tester) async {
    bloc = mockBlocWithState(ChatsListEmpty()) as MockMatcherBloc;

    await pumpScreen(tester, bloc);

    expect(tester.takeException(), isNull);
    await tester.pumpAndSettle(); 

    final imageFinder = find.byType(Image);
    expect(imageFinder, findsOneWidget);

    final screenSize = tester.binding.window.physicalSize 
      / tester.binding.window.devicePixelRatio; 
      
    final rect = tester.getRect(imageFinder);
    expect(rect.left >= 0, true);
    expect(rect.right <= screenSize.width, true);
    expect(rect.top >= 0, true);
    expect(rect.bottom <= screenSize.height, true);
  });
}
