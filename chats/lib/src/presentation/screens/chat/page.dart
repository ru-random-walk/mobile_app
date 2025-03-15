import 'dart:ui';

import 'package:auth/auth.dart';
import 'package:chats/src/data/data_source/chat_socket.dart';
import 'package:chats/src/data/repository/chat_messaging.dart';
import 'package:chats/src/domain/entity/meet_data/invite.dart';
import 'package:chats/src/domain/entity/message/message.dart';
import 'package:chats/src/domain/use_case/get_messages.dart';
import 'package:chats/src/domain/use_case/send_message.dart';
import 'package:chats/src/presentation/screens/chat/args.dart';
import 'package:chats/src/presentation/screens/chat/bloc/chat_bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';

part 'widgets/screen.dart';
part 'widgets/message/text.dart';
part 'widgets/message/widget.dart';
part 'widgets/date_separator.dart';
part 'widgets/app_bar.dart';
part 'widgets/dialog_picker/meet_data_dialog.dart';
part 'widgets/dialog_picker/widgets/button.dart';
part 'widgets/dialog_picker/widgets/data_row.dart';
part 'widgets/dialog_picker/widgets/row/date.dart';
part 'widgets/dialog_picker/widgets/row/time.dart';
part 'widgets/dialog_picker/widgets/row/place.dart';
part 'widgets/dialog_picker/widgets/close_button.dart';
part 'widgets/dialog_picker/widgets/pickers.dart';
part 'widgets/message/shared/base.dart';
part 'widgets/message/invitation.dart';
part 'widgets/body/data.dart';
part 'widgets/body/loading.dart';

class ChatPage extends StatefulWidget {
  final ChatPageArgs args;

  const ChatPage({
    super.key,
    required this.args,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final ChatPageArgs args;

  @override
  void initState() {
    super.initState();
    args = widget.args;
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ru');
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => GetMessagesUseCase(
            currentUserId: args.currentUserId,
            chatId: args.chatId,
          ),
        ),
        Provider(
          create: (_) => ChatMessagingRepository(
            ChatMessagingSocketSource(
              tokenStorage: TokenStorage(),
              chatId: args.chatId,
            ),
            args.currentUserId,
          ),
        ),
        Provider(
          create: (context) => SendMessageUseCase(
            context.read<ChatMessagingRepository>(),
            args.chatId,
            args.currentUserId,
            args.companion.id,
          ),
        ),
      ],
      child: BlocProvider(
        create: (context) => ChatBloc(
          context.read(),
          context.read<ChatMessagingRepository>(),
          context.read(),
        )..add(LoadData()),
        child: _ChatScreen(
          companion: args.companion,
        ),
      ),
    );
  }
}
