part of '../page.dart';

class _MeetingsBody extends StatelessWidget {
  const _MeetingsBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MettingsBloc, MettingsState>(
      builder: (context, state) => switch (state) {
        MettingsLoading() => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        final MettingsData data => _MeetingsBodyDataList(
            data: data.meetings,
          ),
        MettingsEmpty() => const _MeetingsBodyEmpty(),
        MettingsError() => Center(
            child: Text(
              'Что-то пошло не так',
              style: context.textTheme.bodyMMedium,
            ),
          ),
      },
    );
  }
}
