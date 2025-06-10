// ignore_for_file: deprecated_member_use
import 'package:chats/src/presentation/screens/chat_list/bloc/chats_list_bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../helpers/devices.dart';
import '../fixtures/generate_matcher.dart';
import '../fixtures/mocks.dart';
import '../fixtures/test_runner.dart';
import '../fixtures/test_setup.dart';

void main() {

  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('plugins.flutter.io/path_provider');

  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'getTemporaryDirectory' 
      || methodCall.method == 'getApplicationSupportDirectory') {
      return '/tmp';
    }
    return null;
  });
  
  late MockMatcherBloc bloc;

  setUpAll(commonSetUpAll);

  setUp(() async {
    await loadAppFonts();    
  });

  for (final device in testDevices) {
    testGoldens('MatcherScreen - empty state on ${device.name}', 
        (tester) async {
      final imagePath = 'empty_state/clubs_list_empty_${device.name}';
      bloc = mockBlocWithState(ChatsListEmpty()) as MockMatcherBloc;
      await testOnDevice(tester, device, bloc, imagePath);
    });

    testGoldens('MatcherScreen - few on ${device.name}', 
        (tester) async {
      final imagePath = 'few/matcher_few_${device.name}';
      final fewDate = generateMatcher(3);
      bloc = mockBlocWithState(ChatsListData(chats: fewDate))
        as MockMatcherBloc;
      await testOnDevice(tester, device, bloc, imagePath);
    });

    testGoldens('MatcherScreen - many clubs on ${device.name}', 
        (tester) async {
      final imagePath = 'many/matcher_many_${device.name}';
      final manyDate = generateMatcher(10);
      bloc = mockBlocWithState(ChatsListData(chats: manyDate)) 
        as MockMatcherBloc;
      await testOnDevice(tester, device, bloc, imagePath);
    });

    testGoldens('MatcherScreen - error on ${device.name}', (tester) async {
      final imagePath = 'error/matcher_error_${device.name}';
      bloc = mockBlocWithState(ChatsListError(error: BaseError('error', null))) 
        as MockMatcherBloc;
      await testOnDevice(tester, device, bloc, imagePath);
    });
  }
}
