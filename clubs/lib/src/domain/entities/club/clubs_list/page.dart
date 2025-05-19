import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:ui_components/ui_components.dart';

import 'package:clubs/src/domain/entities/club/clubs_list/get_clubs_use_case.dart';
import 'package:clubs/src/data/clubs_api_service.dart';
import 'package:clubs/src/domain/entities/club/clubs_list/bloc/clubs_list_bloc.dart';
import 'package:clubs/src/domain/entities/club/clubs_list/widgets/widget_clubs.dart';
import 'package:clubs/src/domain/entities/club/clubs_list/widgets/filters_clubs/filters_button.dart';
import 'package:clubs/src/domain/entities/club/clubs_list/widgets/add_button.dart';
import 'package:clubs/src/domain/entities/club/text_format/member_format.dart';
import 'package:clubs/src/domain/entities/club/create_and_edit/create_club_page.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/administrator/admin_page.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/not_member/not_member_page.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/member/member_page.dart';

part 'clubs_model.dart';
part 'widgets/app_bar/app_bar.dart';
part 'widgets/app_bar/search_paint.dart';
part 'widgets/app_bar/search_button.dart';
part 'widgets/filters_clubs/clubs_filters.dart';
part 'widgets/body_data.dart';
part 'widgets/screens.dart';


class ClubsListPage extends StatelessWidget {
  const ClubsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return switch (state) {
          ProfileLoading() => const Center(child: CircularProgressIndicator()),
          ProfileError() => Center(child: Text('Ошибка профиля', style: context.textTheme.h4,)),
          ProfileInvalidRefreshToken() => Center(child: Text('Пользователь не авторизован', style: context.textTheme.h4)),
          ProfileData() => Provider(
              create: (context) => GetClubsUseCase(
                userId: state.user.id,
                apiService: ClubApiService(),
              ),
              child: BlocProvider(
                lazy: false,
                create: (context) => ClubsListBloc(
                  context.read<GetClubsUseCase>(),
                )..add(LoadClubsEvent()),
                child: ClubsScreen(currentUserId: state.user.id,),
              ),
            ),
        };
      },
    );
  }
}
