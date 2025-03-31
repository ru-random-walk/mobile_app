part of '../../page.dart';

class _AvailableTimeDatePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final parentState =
        context.findAncestorStateOfType<_AvailableTimeBodyWidgetState>();
    return Padding(
      padding: EdgeInsets.all(4.toFigmaSize),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Дата:',
            style: context.textTheme.bodyXLMedium,
          ),
          const Spacer(),
          PickMeetDateButton(
            width: 220.toFigmaSize,
            size: ButtonSize.M,
            onDateUpdated: (date) => parentState?.selectedDate = date,
            initialValue: parentState?.selectedDate,
          ),
        ],
      ),
    );
  }
}
