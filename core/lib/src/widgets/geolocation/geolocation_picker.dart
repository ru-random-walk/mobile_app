import 'package:core/core.dart';
import 'package:flutter/material.dart';

import 'page.dart';

Future<Geolocation?> showGeolocationPicker({
  required BuildContext context,
  Geolocation? initialGeolocation,
}) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => PickGeolocationPage(
        initialGeolocation: initialGeolocation,
      ),
    ),
  );
}
