import 'package:auth/auth.dart';
import 'package:auth/src/domain/usecases/user/logout.dart';
import 'package:auth/src/screens/edit_user/page.dart';
import 'package:auth/src/screens/settings/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ui_utils/ui_utils.dart';

part 'widgets/app_bar.dart';
part 'widgets/body/widget.dart';
part 'widgets/body/avatar_and_name.dart';
part 'widgets/body/user_info.dart';
part 'widgets/body/help.dart';

class UserSettingsPage extends StatelessWidget {
  const UserSettingsPage({super.key});

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
          create: (context) => LogoutUseCase(
            context.read(),
          ),
        ),
      ],
      child: BlocProvider(
        create: (context) => SettingsBloc(
          context.read(),
        ),
        child: Scaffold(
          backgroundColor: context.colors.base_0,
          appBar: const _UserSettingsAppBar(),
          body: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              return switch (state) {
                ProfileLoading _ => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ProfileData dataState => _UserSettingsBodyWidget(
                    profile: dataState.user,
                  ),
                _ => Center(
                    child: Text(
                      'Ошибка профиля',
                      style: context.textTheme.h4.copyWith(
                        color: context.colors.base_90,
                      ),
                    ),
                  ),
              };
            },
          ),
        ),
      ),
    );
  }
}
