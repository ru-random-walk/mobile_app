part of '../page.dart';

class _MeetingInfoUserWidget extends StatelessWidget {
  final UserEntity partner;

  const _MeetingInfoUserWidget({required this.partner});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.toFigmaSize),
      child: Row(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colors.main_10,
            ),
            child: Padding(
              padding: EdgeInsets.all(12.toFigmaSize),
              child: SvgPicture.asset(
                'packages/matcher_service/assets/icons/user.svg',
                colorFilter: ColorFilter.mode(
                  context.colors.main_90,
                  BlendMode.srcIn,
                ),
                width: 24.toFigmaSize,
                height: 24.toFigmaSize,
              ),
            ),
          ),
          SizedBox(
            width: 8.toFigmaSize,
          ),
          Text(
            'Партнер:',
            style: context.textTheme.bodyXLMedium.copyWith(
              color: context.colors.main_90,
            ),
          ),
          SizedBox(
            width: 24.toFigmaSize,
          ),
          AvatarUserWidget(
            userId: partner.id,
            photoVersion: partner.photoVersion,
            size: 40.toFigmaSize,
          ),
          SizedBox(
            width: 24.toFigmaSize,
          ),
          Expanded(
            child: Text(
              partner.fullName,
              maxLines: 1,
              style: context.textTheme.bodyXLRegular,
            ),
          ),
        ],
      ),
    );
  }
}
