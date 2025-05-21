import 'package:clubs/src/data/clubs_api_service.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/common/photo_widget.dart';
import 'package:flutter/material.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:auth/auth.dart';
import 'package:core/src/network/page_query/page_query.dart';
import 'package:clubs/src/domain/entities/club/create_and_edit/create_club_page.dart';
import 'package:clubs/src/domain/entities/club/text_format/member_format.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/common/row_menu.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/common/overlay_menu_position.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/common/alert_dialogs.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/common/app_bar.dart';
import 'package:clubs/utils/qraphql_error_utils.dart';

part 'widgets/body.dart';
part 'widgets/member_tile.dart';
part 'widgets/header.dart';
part 'overlay_menu/admin_club_menu.dart';
part 'overlay_menu/change_role_member_menu.dart';
part 'logic/club_admin_controller.dart';

class ClubAdminScreen extends StatefulWidget {
  final String clubId;
  final String currentId;
  final int membersCount;

  const ClubAdminScreen({
    super.key,
    required this.clubId,
    required this.currentId,
    required this.membersCount,
  });

  @override
  State<ClubAdminScreen> createState() => _ClubAdminScreenState();
}

class _ClubAdminScreenState extends State<ClubAdminScreen> {
  final ClubApiService _clubApiService = ClubApiService();
  bool _isLoading = true;
  Map<String, dynamic>? _club;
  ClubAdminController? _controller;

  @override
  void initState() {
    super.initState();
    _loadClub();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _loadClub() async {
    try {
      final result = await getClubInfo(
        clubId: widget.clubId,
        apiService: _clubApiService,
      );

      if (handleGraphQLErrors(context, result,
          fallbackMessage: 'Ошибка загрузки клуба')) {
        setState(() => _isLoading = false);
        return;
      }

      final data = result!['data'];
      setState(() {
        _club = data['getClub'];
        _controller = ClubAdminController(
          clubId: widget.clubId,
          apiService: _clubApiService,
          currentUserId: widget.currentId,
          onUpdate: () => setState(() {}),
          clubName: _club!['name'],
          description: _club?['description'] ?? 'Описание отсутствует',
          approvement:
              List<Map<String, dynamic>>.from(_club!['approvements'] ?? []),
        )..init();
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      showErrorSnackbar(context, 'Произошла ошибка');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.base_0,
      child: SafeArea(
        child: Scaffold(
          appBar: _isLoading || _club == null
              ? null
              : ClubPageAppBar(
                  showMenu: true,
                  onMenuPressed: (dy) => _controller!.showMenuClub(context, dy),
                ),
          body: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _club == null || _controller == null
                  ? const Center(child: Text('Клуб не найден'))
                  : ClubAdminBody(
                      clubName: _club!['name'],
                      description:
                          _club!['description'] ?? 'Описание отсутствует',
                      approvement: List<Map<String, dynamic>>.from(
                          _club!['approvements'] ?? []),
                      clubId: widget.clubId,
                      membersCount: widget.membersCount,
                      apiService: _clubApiService,
                      currentUserId: widget.currentId,
                      controller: _controller!,
                      photoVersion: _club?['photoVersion'] ?? 0,
                    ),
        ),
      ),
    );
  }
}
