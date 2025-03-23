part of '../page.dart';

class _MeetingInfoBodyWidget extends StatelessWidget {
  const _MeetingInfoBodyWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingInfoBloc, MeetingInfoState>(
      builder: (context, state) {
        return switch (state) {
          AppointmentInfoLoading() => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          final AppointmentInfoSuccess ap =>
            _MeetingInfoBodyData(ap.appointment),
          AppointmentInfoError() => Center(
              child: Text(
                'Что-то пошло не так',
                style: context.textTheme.bodyMMedium,
              ),
            ),
          final AvailableTimeInfo at => _MeetingInfoBodyData(at.availableTime),
        };
      },
    );
  }
}
