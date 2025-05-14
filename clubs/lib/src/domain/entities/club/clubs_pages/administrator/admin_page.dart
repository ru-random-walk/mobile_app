import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth/auth.dart';

part '../app_bar.dart';
part 'body.dart';

class ClubAdminScreen extends StatelessWidget {
  final Map<String, dynamic> club;

  const ClubAdminScreen({super.key, required this.club});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.base_0,
      child: SafeArea(
        child: Scaffold(
          appBar: const ClubAdminAppBar(),
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


