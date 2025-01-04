import 'dart:ui';

import 'package:chats/src/domain/entity/message/message.dart';
import 'package:chats/src/presentation/screens/chat/widgets/flat_snapping_scroll/controller.dart';
import 'package:chats/src/presentation/screens/chat/widgets/flat_snapping_scroll/list.dart';
import 'package:chats/src/presentation/screens/geolocation/page.dart';
import 'package:chats/src/presentation/shared/confirm_button.dart';
import 'package:chats/src/presentation/shared/cross_paint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';

part 'widgets/screen.dart';
part 'widgets/message/text.dart';
part 'widgets/message/widget.dart';
part 'widgets/date_separator.dart';
part 'widgets/app_bar.dart';
part 'widgets/dialog_picker/date/lists/month_list.dart';
part 'widgets/dialog_picker/date/lists/day_list.dart';
part 'widgets/dialog_picker/date/lists/year_picker.dart';
part 'widgets/dialog_picker/date/date_picker.dart';
part 'widgets/dialog_picker/base/header/header.dart';
part 'widgets/dialog_picker/base/header/close_button.dart';
part 'widgets/dialog_picker/base/button.dart';
part 'widgets/dialog_picker/date/buttons/buttons_group.dart';
part 'widgets/dialog_picker/time/time_picker.dart';
part 'widgets/dialog_picker/time/lists/hour_list.dart';
part 'widgets/dialog_picker/time/lists/minutes_list.dart';
part 'widgets/dialog_picker/time/time_buttons.dart';
part 'widgets/dialog_picker/meet_data/meet_data_dialog.dart';
part 'widgets/dialog_picker/meet_data/widgets/button.dart';
part 'widgets/dialog_picker/meet_data/widgets/data_row.dart';
part 'widgets/dialog_picker/meet_data/widgets/row/date.dart';
part 'widgets/dialog_picker/meet_data/widgets/row/time.dart';
part 'widgets/dialog_picker/meet_data/widgets/row/place.dart';
part 'widgets/dialog_picker/meet_data/widgets/close_button.dart';
part 'widgets/dialog_picker/meet_data/widgets/pickers.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {    
    initializeDateFormatting('ru');
    return _ChatScreen();
  }
}
