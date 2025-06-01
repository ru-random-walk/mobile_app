import 'dart:ui';

import 'package:auth/auth.dart';
import 'package:chats/src/data/data_source/chat_socket.dart';
import 'package:chats/src/data/repository/chat_messaging.dart';
import 'package:chats/src/domain/entity/meet_data/invite.dart';
import 'package:chats/src/domain/entity/message/base.dart';
import 'package:chats/src/domain/use_case/get_messages.dart';
import 'package:chats/src/domain/use_case/send_message.dart';
import 'package:chats/src/presentation/screens/chat/args.dart';
import 'package:chats/src/presentation/screens/chat/bloc/chat_bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:linkfy_text/linkfy_text.dart';
import 'package:matcher_service/matcher_service.dart';
import 'package:provider/provider.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:url_launcher/url_launcher.dart';

part 'widgets/screen.dart';
part 'widgets/message/text.dart';
part 'widgets/message/widget.dart';
part 'widgets/date_separator.dart';
part 'widgets/app_bar.dart';
part 'widgets/dialog_picker/meet_data_dialog.dart';
part 'widgets/dialog_picker/widgets/data_row.dart';
part 'widgets/dialog_picker/widgets/close_button.dart';
part 'widgets/dialog_picker/widgets/pickers.dart';
part 'widgets/message/shared/base.dart';
part 'widgets/message/invitation.dart';
part 'widgets/body/data.dart';
part 'widgets/body/loading.dart';
part 'widgets/message/menu.dart';

class ChatPage extends StatefulWidget {
  final ChatPageArgs args;
  final void Function(MessageEntity? lastMessage) onLastMessageChanged;

  const ChatPage({
    super.key,
    required this.args,
    required this.onLastMessageChanged,
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
    MessageEntity? lastMessage;

    initializeDateFormatting('ru');
    return PopScope(
      onPopInvokedWithResult: (_, __) =>
          widget.onLastMessageChanged(lastMessage),
      child: MultiProvider(
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
          Provider(
            create: (_) => ApproveAppointmentRequestUseCase(),
          ),
          Provider(
            create: (_) => RejectAppointmentRequestUseCase(),
          ),
        ],
        child: BlocProvider(
          create: (context) => ChatBloc(
            context.read(),
            context.read<ChatMessagingRepository>(),
            context.read(),
            context.read(),
            context.read(),
          )..add(LoadData()),
          child: Builder(
            builder: (context) => BlocListener<ChatBloc, ChatState>(
              listener: (context, state) {
                if (state is ChatData) {
                  lastMessage = state.messages.firstOrNull;
                }
              },
              child: _ChatScreen(
                companion: args.companion,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
