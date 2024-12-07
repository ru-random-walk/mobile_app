import 'package:chats/src/screens/chat/page.dart';
import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';

part 'widgets/screen.dart';
part 'widgets/app_bar/app_bar.dart';
part 'widgets/app_bar/search_paint.dart';
part 'widgets/app_bar/search_button.dart';

class ChatsListPage extends StatelessWidget {
  const ChatsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _ChatsListScreen();
  }
}
