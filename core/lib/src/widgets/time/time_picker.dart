import 'package:core/src/widgets/shared/confirm_button.dart';
import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';

import '../shared/dialog.dart';
import '../shared/flat_snapping_scroll/controller.dart';
import '../shared/flat_snapping_scroll/list.dart';
import '../shared/header/header.dart';
import '../shared/item_extent.dart';
import '../shared/specific_value_button.dart';

part 'widget.dart';
part 'time_buttons.dart';
part 'lists/hour_list.dart';
part 'lists/minutes_list.dart';

Future<TimeOfDay?> showTimePickerDialog({
  required BuildContext context,
  TimeOfDay? initialTime,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return _MeetTimePickerDialog(
        initialTime: initialTime,
      );
    },
  );
}