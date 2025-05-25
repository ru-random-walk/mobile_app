import 'dart:typed_data';

import 'package:auth/auth.dart';
import 'package:auth/src/data/repositories/avatar_cache.dart';
import 'package:auth/src/data/repositories/avatars_info.dart';
import 'package:auth/src/data/repositories/user.dart';
import 'package:auth/src/domain/entities/user/update_user_info.dart';
import 'package:auth/src/domain/usecases/user/update_info.dart';
import 'package:auth/src/screens/edit_user/bloc/user_settings_bloc.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';

part 'widgets/app_bar.dart';
part 'widgets/editable_block.dart';
part 'widgets/body.dart';

class EditUserInfoPage extends StatefulWidget {
  final DetailedUserEntity profile;

  const EditUserInfoPage({super.key, required this.profile});

  @override
  State<EditUserInfoPage> createState() => _EditUserInfoPageState();
}

class _EditUserInfoPageState extends State<EditUserInfoPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => UserRepository(
            UsersDataSource(),
          ),
        ),
        Provider(
          create: (_) => AvatarCacheRepository(),
        ),
        Provider(
          create: (_) => UserAvatarsDatabaseInfoRepository(
            context.read(),
          ),
        ),
        Provider(
          create: (context) => UpdateUserInfoUseCase(
            context.read(),
          ),
        ),
        Provider(
          create: (context) => SetPhotoForObjectWithId(
            cache: context.read<AvatarCacheRepository>(),
            dbInfo: context.read<UserAvatarsDatabaseInfoRepository>(),
            sender: context.read<UserRepository>(),
          ),
        )
      ],
      child: BlocProvider(
        create: (context) => UserSettingsBloc(
          context.read(),
          context.read(),
          (newUserEntity) {
            final profileBloc = context.read<ProfileBloc>();
            profileBloc.add(
              ProfileUpdatedEvent(user: newUserEntity),
            );
          },
        ),
        child: ColoredBox(
          color: context.colors.base_0,
          child: SafeArea(
            child: Scaffold(
              appBar: const _EditUserAppBarWidget(),
              body: _EditUserInfoBodyWidget(widget.profile),
            ),
          ),
        ),
      ),
    );
  }
}
