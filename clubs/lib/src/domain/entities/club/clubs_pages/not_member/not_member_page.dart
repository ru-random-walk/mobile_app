import 'package:clubs/src/data/clubs_api_service.dart';
import 'package:flutter/material.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:auth/auth.dart';
import 'package:core/src/network/page_query/page_query.dart';
import 'package:clubs/src/domain/entities/club/create_and_edit/create_club_page.dart';

import 'package:clubs/src/domain/entities/club/text_format/member_format.dart';

part 'widgets/app_bar.dart';

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
    _loadClubInfo();
  }

  Future<void> _loadClubInfo() async {
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

    return ColoredBox(
      color: context.colors.base_0,
      child: SafeArea(
        child: Scaffold(
          appBar: const ClubNotMemberAppBar(),
          body: Padding(
            padding: EdgeInsets.symmetric(
            vertical: 4.toFigmaSize,
            horizontal: 20.toFigmaSize,
          ),
            child: ListView(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.toFigmaSize),
                    child: SizedBox(
                      width: 240.toFigmaSize,
                      height: 240.toFigmaSize,
                      child: Image.asset(
                        'packages/clubs/assets/images/avatar.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.toFigmaSize),
                Center(
                  child: Text(
                    clubName,
                    style: context.textTheme.h4.copyWith(
                      color: context.colors.base_90,
                    ),
                  ),
                ),
                SizedBox(height: 16.toFigmaSize),
                Row(
                  children: [
                    SvgPicture.asset(
                      'packages/clubs/assets/icons/clubs.svg',
                      width: 24.toFigmaSize,
                      height: 24.toFigmaSize,
                      colorFilter: ColorFilter.mode(
                        context.colors.base_80,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 4.toFigmaSize),
                    Text(formatMemberCount(membersCount),
                      style: context.textTheme.bodyLRegular.copyWith(
                      color: context.colors.base_90,
                    ),),
                    const Spacer(),
                    Text('Вы не в группе', 
                      style: context.textTheme.bodyLRegular.copyWith(
                      color: context.colors.base_50,
                    ),),
                  ],
                ),
                SizedBox(height: 16.toFigmaSize),
                Text(
                  'Описание:',
                  style: context.textTheme.bodyLMedium.copyWith(
                  color: context.colors.base_90,
                  ),
                ),
                Text(
                  description,
                  style: context.textTheme.bodyLRegular.copyWith(
                  color: context.colors.base_80,
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8.toFigmaSize,
              horizontal: 16.toFigmaSize,
            ),
            child: SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: 'Вступить',
                onPressed: () async {
                  try {
                    final result = await addMemberInClub(
                      clubId: widget.clubId,
                      memberId: widget.currentId,
                      apiService: _clubApiService,
                    );
                    final member = result?['addMemberInClub'];

                    final message = member != null
                        ? 'Вы успешно вступили в клуб'
                        : 'Не удалось вступить в клуб';

                    if (!mounted) return;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(message)),
                    );

                    if (member != null) {
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Ошибка: $e')),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
