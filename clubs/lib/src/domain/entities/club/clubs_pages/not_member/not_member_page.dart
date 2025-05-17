import 'package:clubs/src/data/clubs_api_service.dart';
import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:clubs/src/domain/entities/club/text_format/member_format.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/common/app_bar.dart';
import 'package:clubs/src/domain/entities/club/clubs_pages/member/member_page.dart';
part 'widgets/body.dart';
part 'widgets/bottom_button.dart';

class NotMemberPage extends StatefulWidget {
  final String clubId;
  final String currentId;
  final int membersCount;

  const NotMemberPage({
    super.key,
    required this.clubId,
    required this.currentId,
    required this.membersCount,
  });

  @override
  State<NotMemberPage> createState() => _NotMemberPageState();
}

class _NotMemberPageState extends State<NotMemberPage> {
  final ClubApiService _clubApiService = ClubApiService();
  Map<String, dynamic>? clubData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadClub();
  }

  Future<void> _loadClub() async {
    try {
      final data = await getClubInfo(
        clubId: widget.clubId,
        apiService: _clubApiService,);
      setState(() {
        clubData = data!['getClub'];
        isLoading = false;
      });
    } catch (e) {
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
    final membersCount = widget.membersCount;
    final List<Map<String, dynamic>> approvements = List<Map<String, dynamic>>.from(clubData?['approvements'] ?? []);


    return ColoredBox(
      color: context.colors.base_0,
      child: SafeArea(
        child: Scaffold(
          appBar: const ClubPageAppBar(),
          body: ClubNotMemberBody(
            clubName: clubName,
            description: description,
            membersCount: membersCount,
            approvements: approvements,
          ),
          bottomNavigationBar: approvements.isEmpty
            ? BottomButton(
              clubId: widget.clubId,
              userId: widget.currentId,
              membersCount: membersCount,
              clubApiService: _clubApiService,
            )
          : null,
        ),
      ),
    );
  }
}
