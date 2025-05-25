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





























// class _TestFlutterView implements FlutterView {
//   @override
//   final Size physicalSize;

//   @override
//   final double devicePixelRatio;

//   _TestFlutterView({
//     required this.physicalSize,
//     required this.devicePixelRatio,
//   });

//   @override
//   dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
// }

// void main() {
//   late MockChatsListBloc bloc;

//   setUpAll(() async {
//     HttpOverrides.global = null;
//     await loadAppFonts();
//     registerFallbackValue(GetChatsEvent(resetPagination: true));
//     registerFallbackValue(ChatsListLoading());
//   }); 

//     // testGoldens('Empty state', (tester) async {
//     //   bloc = mockBlocWithState(ChatsListEmpty()) as MockChatsListBloc;
//     //   for (final device in testDevices) {
//     //     final imagePath = 'empty_state/chats_list_empty_${device.name}';
//     //     await _pumpChatsListScreen(tester, bloc, device, imagePath);
//     //   }
//     // });
//      for (final device in testDevices) {
//       group('Few chats on ${device.name}', () {

//     //     setUp(() {
//       // getFlutterView = () => _TestFlutterView(
//       //   physicalSize: Size(
//       //     device.size.width * device.pixelRatio,
//       //     device.size.height * device.pixelRatio,
//       //   ),
//       //   devicePixelRatio: device.pixelRatio,
//       // );
//     // });

//     testGoldens('Few chats', (tester) async {
//       final fewChats = generateChats(3);
//       bloc = mockBlocWithState(ChatsListData(chats: fewChats)) as MockChatsListBloc;
 
//         final imagePath = 'few_chats/chats_list_few_${device.name}';
        
//         getFlutterView = () => _TestFlutterView(
//           physicalSize: Size(
//             device.size.width * device.pixelRatio,
//             device.size.height * device.pixelRatio,
//           ),
//           devicePixelRatio: device.pixelRatio,
//         );

        
//         await _pumpChatsListScreen(tester, bloc, device, imagePath);
//      getFlutterView = () => WidgetsBinding.instance.platformDispatcher.views.first;

//     });
//       });
//  }
//     // testGoldens('Many chats', (tester) async {
//     //   final manyChats = generateChats(13);
//     //   bloc = mockBlocWithState(ChatsListData(chats: manyChats)) as MockChatsListBloc;
//     //   for (final device in testDevices) {
//     //     final imagePath = 'many_chats/chats_list_many_${device.name}';
//     //     await _pumpChatsListScreen(tester, bloc, device, imagePath);
//     //   }
//     // });
//   }

// Future<void> _pumpChatsListScreen(
//     WidgetTester tester, ChatsListBloc bloc, 
//     TestDevice device, String path,) async {

//   final physicalSize = Size(
//     device.size.width * device.pixelRatio,
//     device.size.height * device.pixelRatio,
//   );

//   tester.binding.window.physicalSizeTestValue = physicalSize;
//   tester.binding.window.devicePixelRatioTestValue = device.pixelRatio;

//     final testValue = 60.toFigmaSize; // из основного extension

//     print('testValue = $testValue');

// print('16.toFigmaSize = ${16.toFigmaSize}');


//   await mockNetworkImagesFor(() async {
//     await tester.pumpWidget(
//       MediaQuery(
//         data: MediaQueryData(
//           size: device.size,
//           devicePixelRatio: device.pixelRatio,
//           padding: device.safeArea,
//           textScaleFactor: 1.0,
//         ),
//         child: MaterialApp(
//           theme: lightTheme.copyWith(platform: TargetPlatform.iOS),
//           home: BlocProvider<ChatsListBloc>.value(
//             value: bloc,
//             child: const ChatsListScreen(currentUserId: 'user_test1'),
//           ),
//         ),
//       ),    
//     );

//     await tester.pumpAndSettle();

//     await screenMatchesGolden(tester, path);

//     addTearDown(() {
//   tester.binding.window.clearPhysicalSizeTestValue();
//   tester.binding.window.clearDevicePixelRatioTestValue();
// });


//   });
// }
