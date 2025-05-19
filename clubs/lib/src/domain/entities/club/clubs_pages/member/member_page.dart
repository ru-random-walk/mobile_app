import 'package:clubs/src/data/clubs_api_service.dart';
import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:clubs/src/domain/entities/club/text_format/member_format.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/common/app_bar.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/common/row_menu.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/common/overlay_menu_position.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/common/alert_dialogs.dart';
import 'package:clubs/utils/qraphql_error_utils.dart';

part 'overlay_menu/overlay_menu.dart';
part 'widgets/body.dart';
part 'logic/club_member_controller.dart';

class MemberPage extends StatefulWidget {
  final String clubId;
  final String currentId;
  final int membersCount;

  const MemberPage({
    super.key,
    required this.clubId,
    required this.currentId,
    required this.membersCount,
  });

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  final ClubApiService _clubApiService = ClubApiService();
  Map<String, dynamic>? clubData;
  bool isLoading = true;
  late ClubMemberMenuController _menuController;

  @override
  void initState() {
    super.initState();
    _menuController = ClubMemberMenuController(
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
        fallbackMessage: 'Не удалось загрузить данные клуба',
      )) return;

      setState(() {
        clubData = data?['data']?['getClub'];
        isLoading = false;
      });
    } catch (e) {
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
    return ColoredBox(
      color: context.colors.base_0,
      child: SafeArea(
        child: Scaffold(
          appBar: ClubPageAppBar(
            showMenu: true,
            onMenuPressed: _menuController.showMenu,
          ),
          body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : clubData == null
                ? const Center(child: Text('Клуб не найден'))
                : ClubMemberBody(
                    clubName: clubData?['name'],
                    description: clubData?['description'] ?? 'Описание отсутствует',
                    membersCount: widget.membersCount,
                ),
        ),
      ),
    );
  }
}
