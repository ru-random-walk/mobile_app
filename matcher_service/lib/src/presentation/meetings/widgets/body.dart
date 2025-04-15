part of '../page.dart';

class _MeetingsBody extends StatelessWidget {
  const _MeetingsBody();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async =>
          context.read<MettingsBloc>().add(GetMettingsEvent()),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          BlocBuilder<MettingsBloc, MettingsState>(
            builder: (context, state) => switch (state) {
              MettingsLoading() => const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
              final MettingsData data => _MeetingsBodyDataList(
                  data: data.meetings,
                ),
              MettingsEmpty() => const _MeetingsBodyEmpty(),
              MettingsError() => SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'Что-то пошло не так',
                      style: context.textTheme.bodyMMedium,
                    ),
                  ),
                ),
            },
          ),
        ],
      ),
    );
  }
}
