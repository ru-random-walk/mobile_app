import 'package:clubs/src/data/clubs_api_service.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/common/exit_menu_club/exit_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:clubs/src/domain/entities/club/text_format/member_format.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/common/app_bar.dart';
import 'package:clubs/utils/qraphql_error_utils.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/common/request_list/confirmation_request_row.dart';

part 'body.dart';
part 'join_requirements.dart';

class ClubInspectorScreen extends StatefulWidget {
  final String clubId;
  final String currentId;
  final int membersCount;

  const ClubInspectorScreen({
    super.key, 
    required this.clubId,
    required this.currentId,
    required this.membersCount,
  });

  @override
  State<ClubInspectorScreen> createState() => _ClubInspectorScreenState();
}

class _ClubInspectorScreenState extends State<ClubInspectorScreen> {
  final ClubApiService _clubApiService = ClubApiService();
  Map<String, dynamic>? clubData;
  bool isLoading = true;
  late ExitMenuController _menuController;

  @override
  void initState() {
    super.initState();
    _menuController = ExitMenuController(
      context: context,
      clubId: widget.clubId,
      userId: widget.currentId,
      apiService: _clubApiService,
      onLeaveSuccess: () => Navigator.of(context).pop(),
    );
    _loadClub();
  }

  Future<void> _loadClub() async {
    try {
      final data = await getClubInfo(
        clubId: widget.clubId,
        apiService: _clubApiService,);

      if (handleGraphQLErrors(
        context,
        data,
        fallbackMessage: 'Не удалось загрузить данные группы',
      )) return;

      setState(() {
        clubData = data?['data']?['getClub'];
        isLoading = false;
      });
    } catch (e) {
      print('Ошибка при загрузке групп: $e');
      showErrorSnackbar(context, 'Произошла ошибка');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || clubData == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator.adaptive()),
      );
    }

    final clubName = clubData?['name'];
    final description = clubData?['description'] ?? 'Описание отсутствует';
    final List<Map<String, dynamic>> approvements = List<Map<String, dynamic>>.from(clubData?['approvements'] ?? []);

    return ColoredBox(
      color: context.colors.base_0,
      child: SafeArea(
        child: Scaffold(
          appBar: ClubPageAppBar(
            showMenu: true,
            onMenuPressed: _menuController.showMenu,
          ),
          body: ClubInspectorBody(
            clubName: clubName,
            description: description,
            membersCount: widget.membersCount,
            clubId: widget.clubId,
            userId: widget.currentId,
            apiService: _clubApiService,
            approvements: approvements,
          ),
        ),
      ),
    );
  }
}
