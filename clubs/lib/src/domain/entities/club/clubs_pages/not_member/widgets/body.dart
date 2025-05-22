part of '../not_member_page.dart';

class ClubNotMemberBody extends StatelessWidget {
  final String clubName;
  final String description;
  final int membersCount;
  final List<Map<String, dynamic>> approvements;
  final String clubId;
  final String userId;
  final int photoVersion;
  final ClubApiService clubApiService;

  const ClubNotMemberBody({
    super.key,
    required this.clubName,
    required this.description,
    required this.membersCount,
    required this.approvements,
    required this.clubId,
    required this.userId,
    required this.photoVersion,
    required this.clubApiService,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 4.toFigmaSize,
        horizontal: 20.toFigmaSize,
      ),
      child: ListView(
        children: [
          ClubDetailPhotoWidget(
            clubId: clubId,
            photoVersion: photoVersion,
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
              Text(
                formatMemberCount(membersCount),
                style: context.textTheme.bodyLRegular.copyWith(
                  color: context.colors.base_90,
                ),
              ),
              const Spacer(),
              Text(
                'Вы не в группе',
                style: context.textTheme.bodyLRegular.copyWith(
                  color: context.colors.base_50,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.toFigmaSize),
          Text(
            'Описание:',
            style: context.textTheme.bodyLMedium.copyWith(
              color: context.colors.base_90,
            ),
          ),
          SizedBox(height: 4.toFigmaSize),
          Text(
            description,
            style: context.textTheme.bodyLRegular.copyWith(
              color: context.colors.base_80,
            ),
          ),
          if (approvements.isNotEmpty)
            JoinRequirements(
              approvements: approvements,
              clubId: clubId,
              userId: userId,
              membersCount: membersCount,
              clubApiService: clubApiService,
            ),
        ],
      ),
    );
  }
}
