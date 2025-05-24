part of '../../page.dart';

class _UserAvatarAndNameWidget extends StatelessWidget {
  final DetailedUserEntity profile;

  const _UserAvatarAndNameWidget(this.profile);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AvatarUserWidget(
          userId: profile.id,
          photoVersion: profile.photoVersion,
          size: 100.toFigmaSize,
        ),
        SizedBox(width: 20.toFigmaSize),
        Expanded(
          child: Text(
            profile.fullName,
            style: context.textTheme.h4.copyWith(
              color: context.colors.base_90,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 20.toFigmaSize),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => EditUserInfoPage(
                  profile: profile,
                ),
              ),
            );
          },
          child: Icon(
            Icons.edit_outlined,
            color: context.colors.base_50,
            size: 24.toFigmaSize,
          ),
        ),
      ],
    );
  }
}
