part of '../../page.dart';

class _AvailableTimePicker extends StatelessWidget {
  const _AvailableTimePicker();

  @override
  Widget build(BuildContext context) {
    final parentState =
        context.findAncestorStateOfType<_AvailableTimeBodyWidgetState>();
    return Padding(
      padding: EdgeInsets.all(4.toFigmaSize),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Свободное время:',
            style: context.textTheme.bodyXLMedium,
          ),
          SizedBox(
            height: 12.toFigmaSize,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PickMeetTimeButton(
                width: 160.toFigmaSize,
                size: ButtonSize.M,
                onTimeUpdated: (date) => parentState?.selectedTimeFrom = date,
              ),
              Text(
                '-',
                style: context.textTheme.bodyLRegular,
              ),
              PickMeetTimeButton(
                width: 160.toFigmaSize,
                size: ButtonSize.M,
                onTimeUpdated: (date) => parentState?.selectedTimeUntil = date,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
