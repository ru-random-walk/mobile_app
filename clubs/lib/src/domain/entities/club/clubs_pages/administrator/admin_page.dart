import 'package:clubs/src/data/clubs_api_service.dart';
import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth/auth.dart';

part '../app_bar.dart';
part 'body.dart';
part 'member_tile.dart';
part 'overlay_menu/overlay_menu.dart';
part 'overlay_menu/row_menu.dart';

class ClubAdminScreen extends StatelessWidget {
  final Map<String, dynamic> club;

  const ClubAdminScreen({super.key, required this.club});

  @override
  Widget build(BuildContext context) {
    final ClubApiService clubApiService = ClubApiService();
    return ColoredBox(
      color: context.colors.base_0,
      child: SafeArea(
        child: Scaffold(
          appBar: ClubAdminAppBar(
            apiService: clubApiService,
            clubId: club['id'],
          ),
          body: ClubAdminBody(
            title: club['name'],
            description: club['description'],
            approvement: List<Map<String, dynamic>>.from(club['approvements'] ?? []),
            members: List<Map<String, dynamic>>.from(club['members'] ?? []),
          ),
        ),
      ),
    );
  }
}


