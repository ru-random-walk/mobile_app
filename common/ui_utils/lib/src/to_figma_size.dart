import 'dart:ui';

import 'package:flutter/widgets.dart';

const _figmaScreenWidth = 413;

extension ToFigmaSize on num {
  FlutterView get _view =>
      WidgetsBinding.instance.platformDispatcher.views.first;

  num get _widthScreen => (_view.physicalSize / _view.devicePixelRatio).width;

  double get toFigmaSize {
    return _widthScreen * this / _figmaScreenWidth;
  }
}
