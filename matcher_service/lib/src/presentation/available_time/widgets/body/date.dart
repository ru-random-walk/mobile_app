part of '../../page.dart';

class _AvailableTimeDatePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            onDateUpdated: (date) => context
                .findAncestorStateOfType<_AvailableTimeBodyWidgetState>()
                ?.selectedDate = date,
          ),
        ],
      ),
    );
  }
}
