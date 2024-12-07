import 'package:chats/src/domain/entity/message/message.dart';
import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';

part 'widgets/screen.dart';
part 'widgets/message/text.dart';
part 'widgets/message/widget.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _ChatScreen();
  }
}
