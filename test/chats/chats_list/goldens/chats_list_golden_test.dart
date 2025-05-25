import 'package:chats/src/presentation/screens/chat_list/bloc/chats_list_bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../../helpers/devices.dart';
import '../fixtures/generate_chats.dart';
import '../fixtures/mocks.dart';
import '../fixtures/test_runner.dart';
import '../fixtures/test_setup.dart';

@Tags(['golden'])
void main() {

  TestWidgetsFlutterBinding.ensureInitialized();
  const MethodChannel channel = MethodChannel('plugins.flutter.io/path_provider');

  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'getTemporaryDirectory' || methodCall.method == 'getApplicationSupportDirectory') {
      return '/tmp';
    }
    return null;
  });
  
  late MockChatsListBloc bloc;

  setUpAll(commonSetUpAll);

  setUp(() async {
    await loadAppFonts();    
  });

  for (final device in testDevices) {
    testGoldens('Chats List Screen - empty state on ${device.name}', (tester) async {
      final imagePath = 'empty_state/chats_list_empty_${device.name}';
      bloc = mockBlocWithState(ChatsListEmpty()) as MockChatsListBloc;
      await testOnDevice(tester, device, bloc, imagePath);
    });

    testGoldens('Chats List Screen - few chats on ${device.name}', (tester) async {
      final imagePath = 'few_chats/chats_list_few_chats_${device.name}';
      final fewChats = generateChats(3);
      bloc = mockBlocWithState(ChatsListData(chats: fewChats)) as MockChatsListBloc;
      await testOnDevice(tester, device, bloc, imagePath);
    });

    testGoldens('Chats List Screen - many chats on ${device.name}', (tester) async {
      final imagePath = 'many_chats/chats_list_many_chats_${device.name}';
      final manyChats = generateChats(13);
      bloc = mockBlocWithState(ChatsListData(chats: manyChats)) as MockChatsListBloc;
      await testOnDevice(tester, device, bloc, imagePath);
    });

    testGoldens('Chats List Screen - error on ${device.name}', (tester) async {
      final imagePath = 'error/chats_list_many_chats_${device.name}';
      bloc = mockBlocWithState(ChatsListError(error: BaseError('error', null))) as MockChatsListBloc;
      await testOnDevice(tester, device, bloc, imagePath);
    });
  }
}
