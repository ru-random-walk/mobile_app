import 'package:flutter/material.dart';

class TestDevice {
  final String name;
  final Size size;
  final double pixelRatio;
  final EdgeInsets safeArea;

  const TestDevice({
    required this.name,
    required this.size,
    required this.pixelRatio,
    required this.safeArea,
  });
}

const List<TestDevice> testDevices = [
  TestDevice(
    name: 'pixel_4_xl',
    size: Size(411, 869),
    pixelRatio: 3.5,
    safeArea: EdgeInsets.only(top: 24, bottom: 34),
  ),
  TestDevice(
    name: 'iphone_se',
    size: Size(375, 667),
    pixelRatio: 2.0,
    safeArea: EdgeInsets.only(top: 20),
  ),
  TestDevice(
    name: 'ipad',
    size: Size(768, 1024),
    pixelRatio: 2.0,
    safeArea: EdgeInsets.all(20),
  ),
  TestDevice(
    name: 'iphone_5',
    size: Size(320, 568),
    pixelRatio: 2.0,
    safeArea: EdgeInsets.only(top: 20),
  ),
];
