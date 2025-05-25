import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';

import '../../../helpers/devices.dart';
import 'mocks.dart';

import 'pump_screen.dart';

Future<void> testOnDevice(WidgetTester tester, TestDevice device, 
    MockChatsListBloc bloc, String imagePath) async {

  final binding = TestWidgetsFlutterBinding.ensureInitialized();
  binding.window.devicePixelRatioTestValue = device.pixelRatio;
  binding.window.physicalSizeTestValue = Size(
    device.size.width * device.pixelRatio,
    device.size.height * device.pixelRatio,
  );
  await binding.setSurfaceSize(device.size);
  await pumpScreen(tester, bloc);

  await tester.pumpAndSettle();
  await screenMatchesGolden(tester, imagePath);

  binding.window.clearPhysicalSizeTestValue();
  binding.window.clearDevicePixelRatioTestValue();
  await binding.setSurfaceSize(null);
  binding.reset();
}
