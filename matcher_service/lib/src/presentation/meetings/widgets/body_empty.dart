part of '../page.dart';

class _MeetingsBodyEmpty extends StatelessWidget {
  const _MeetingsBodyEmpty();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'packages/matcher_service/assets/images/no_appointments.svg',
          ),
          SizedBox(
            height: 31.5.toFigmaSize,
          ),
          Text(
            'Здесь пока нет прогулок',
            style: context.textTheme.h5,
          ),
          SizedBox(
            height: 8.toFigmaSize,
          ),
          Text(
            'Создайте свою встречу, чтобы найти компанию',
            style: context.textTheme.bodyMItalic.copyWith(
              color: context.colors.base_50,
            ),
          ),
          SizedBox(
            height: 31.5.toFigmaSize,
          ),
          CustomButton(
            isMaxWidth: false,
            text: 'Создать встречу',
            onPressed: () => context
                .findAncestorStateOfType<_MatcherPageState>()
                ?.addAvailableTime(context),
          ),
        ],
      ),
    );
  }
}
