part of '../page.dart';

class _MeetingInfoClubsWidget extends StatelessWidget {
  final List<ShortClubEntity> clubs;

  const _MeetingInfoClubsWidget({required this.clubs});

  @override
  Widget build(BuildContext context) {
    if (clubs.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return Padding(
        padding: EdgeInsets.only(left: 8.toFigmaSize),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colors.main_10,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.toFigmaSize),
                    child: SvgPicture.asset(
                      'packages/matcher_service/assets/icons/group.svg',
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
                  'Общие группы:',
                  style: context.textTheme.bodyXLMedium.copyWith(
                    color: context.colors.main_90,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 16.toFigmaSize,
                left: 4.toFigmaSize,
              ),
              child: Wrap(
                spacing: 8.toFigmaSize,
                runSpacing: 8.toFigmaSize,
                children: [
                  for (final club in clubs)
                    DecoratedBox(
                      decoration: BoxDecoration(
                          color: context.colors.main_10,
                          borderRadius: BorderRadius.circular(16.toFigmaSize)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 8.toFigmaSize,
                          horizontal: 20.toFigmaSize,
                        ),
                        child: Text(
                          club.name,
                          style: context.textTheme.bodyMRegularBase70.copyWith(
                            color: context.colors.base_80,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
}
