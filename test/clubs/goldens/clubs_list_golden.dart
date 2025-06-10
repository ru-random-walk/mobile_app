// ignore_for_file: deprecated_member_use
import 'package:chats/src/presentation/screens/chat_list/bloc/chats_list_bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../helpers/devices.dart';
import '../fixtures/generate_clubs.dart';
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
  
  late MockClubsListBloc bloc;

  setUpAll(commonSetUpAll);

  setUp(() async {
    await loadAppFonts();    
  });

  for (final device in testDevices) {
    testGoldens('Clubs List Screen - empty state on ${device.name}', 
        (tester) async {
      final imagePath = 'empty_state/clubs_list_empty_${device.name}';
      bloc = mockBlocWithState(ChatsListEmpty()) as MockClubsListBloc;
      await testOnDevice(tester, device, bloc, imagePath);
    });

    testGoldens('Clubs List Screen - few clubs on ${device.name}', 
        (tester) async {
      final imagePath = 'few_clubs/clubs_list_few_${device.name}';
      final fewClubs = generateClubs(3);
      bloc = mockBlocWithState(ChatsListData(chats: fewClubs))
        as MockClubsListBloc;
      await testOnDevice(tester, device, bloc, imagePath);
    });

    testGoldens('Clubs List Screen - many clubs on ${device.name}', 
        (tester) async {
      final imagePath = 'many_clubs/clubs_list_many_${device.name}';
      final manyClubs = generateClubs(13);
      bloc = mockBlocWithState(ChatsListData(chats: manyClubs)) 
        as MockClubsListBloc;
      await testOnDevice(tester, device, bloc, imagePath);
    });

    testGoldens('Clubs List Screen - error on ${device.name}', (tester) async {
      final imagePath = 'error/clubs_list_error_${device.name}';
      bloc = mockBlocWithState(ChatsListError(error: BaseError('error', null))) 
        as MockClubsListBloc;
      await testOnDevice(tester, device, bloc, imagePath);
    });
  }
}
