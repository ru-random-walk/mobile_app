import 'package:auth/auth.dart';
import 'package:chats/src/domain/entity/chat/chat.dart';
import 'package:chats/src/domain/entity/message/message.dart';
import 'package:chats/src/domain/use_case/get_chats.dart';
import 'package:chats/src/presentation/screens/chat/args.dart';
import 'package:chats/src/presentation/screens/chat/page.dart';
import 'package:chats/src/presentation/screens/chat_list/bloc/chats_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';

part 'widgets/screen.dart';
part 'widgets/app_bar/app_bar.dart';
part 'widgets/app_bar/search_paint.dart';
part 'widgets/app_bar/search_button.dart';
part 'widgets/body/data.dart';
part 'widgets/body/empty.dart';

class ChatsListPage extends StatelessWidget {
  const ChatsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return switch (state) {
          ProfileLoading() => throw UnimplementedError(),
          ProfileData() => Provider(
              create: (context) => GetChatsUseCase(
                userId: state.user.id,
              ),
              child: BlocProvider(
                lazy: false,
                create: (context) => ChatsListBloc(
                  context.read(),
                )..add(GetChatsEvent(resetPagination: false)),
                child: _ChatsListScreen(
                  currentUserId: state.user.id,
                ),
              ),
            ),
          ProfileError() => throw UnimplementedError(),
          ProfileInvalidRefreshToken() => throw UnimplementedError(),
        };
      },
    );
  }
}
