part of '../page.dart';

class _MeetingInfoBodyWidget extends StatelessWidget {
  const _MeetingInfoBodyWidget();

  @override
  Widget build(BuildContext context) {
    return BlocListener<MeetingInfoBloc, MeetingInfoState>(
      listener: (context, state) {
        switch (state) {
          case AppointmentDeleteSuccess _:
          case AvailableTimeDeleteSuccess _:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Встреча удалена',
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
            Navigator.of(context).pop();
          case AppointmentDeleteError():
          case AvailableTimeDeleteError():
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Что-то пошло не так',
                ),
                behavior: SnackBarBehavior.floating,
              ),
            );
          default:
        }
      },
      child: BlocBuilder<MeetingInfoBloc, MeetingInfoState>(
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
            final AvailableTimeInfo at =>
              _MeetingInfoBodyData(at.availableTime),
          };
        },
      ),
    );
  }
}
