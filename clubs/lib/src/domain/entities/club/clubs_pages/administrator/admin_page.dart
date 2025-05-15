import 'package:clubs/src/data/clubs_api_service.dart';
import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth/auth.dart';
import 'package:core/src/network/page_query/page_query.dart';
import 'package:auth/auth.dart';

part '../app_bar.dart';
part 'widgets/body.dart';
part 'widgets/member_tile.dart';
part 'widgets/header.dart';
part 'overlay_menu/overlay_menu.dart';
part 'overlay_menu/row_menu.dart';

class ClubAdminScreen extends StatefulWidget  {
  final String clubId;

  const ClubAdminScreen({super.key, required this.clubId});

  @override
  State<ClubAdminScreen> createState() => _ClubAdminScreenState();
}

class _ClubAdminScreenState extends State<ClubAdminScreen> {
  final ClubApiService _clubApiService = ClubApiService();
  bool _isLoading = true;
  Map<String, dynamic>? _club;

  @override
  void initState() {
    super.initState();
    _loadClub();
  }

  Future<void> _loadClub() async {
    try {
      final data = await getClubInfo(
        clubId: widget.clubId,
        apiService: _clubApiService,
      );

      if (data != null && data['getClub'] != null) {
        setState(() {
          _club = data['getClub'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Ошибка загрузки клуба: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final ClubApiService clubApiService = ClubApiService();
    return ColoredBox(
      color: context.colors.base_0,
      child: SafeArea(
        child: Scaffold(
          appBar: ClubAdminAppBar(
            apiService: clubApiService,
            clubId: widget.clubId,
          ),
          body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _club == null
                ? const Center(child: Text('Клуб не найден'))
                : ClubAdminBody(
                    title: _club!['name'],
                    description: _club!['description'],
                    approvement: List<Map<String, dynamic>>.from(_club!['approvements'] ?? []),
                    clubId: widget.clubId,
                    apiService: _clubApiService,
          ),
        ),
      ),
    );
  }
}


