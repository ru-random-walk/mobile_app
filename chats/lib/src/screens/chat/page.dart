import 'dart:ui';

import 'package:chats/src/domain/entity/message/message.dart';
import 'package:chats/src/screens/chat/widgets/flat_snapping_scroll/controller.dart';
import 'package:chats/src/screens/chat/widgets/flat_snapping_scroll/list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
part 'widgets/dialog_picker/date/buttons/base.dart';
part 'widgets/dialog_picker/date/buttons/buttons_group.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ru');
    return _ChatScreen();
  }
}
