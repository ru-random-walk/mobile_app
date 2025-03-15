import 'package:core/src/widgets/shared/flat_snapping_scroll/list.dart';
import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';

import '../shared/confirm_button.dart';
import '../shared/dialog.dart';
import '../shared/flat_snapping_scroll/controller.dart';
import '../shared/header/header.dart';
import '../shared/item_extent.dart';
import '../shared/specific_value_button.dart';

part 'widget.dart';
part 'lists/day_list.dart';
part 'lists/month_list.dart';
part 'lists/year_picker.dart';
part 'buttons/buttons_group.dart';

Future<DateTime?> showDatePickerDialog({
  required BuildContext context,
  DateTime? initialDate,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return _MeetDatePickerDialog(
        initialDate: initialDate,
      );
    },
  );
}
