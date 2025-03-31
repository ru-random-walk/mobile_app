part of '../../page.dart';

class _AvailableTimeGeolocationPicker extends StatelessWidget {
  const _AvailableTimeGeolocationPicker();

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
            'Место:',
            style: context.textTheme.bodyXLMedium,
          ),
          const Spacer(),
          PickMeetPlaceButton(
            width: 220.toFigmaSize,
            size: ButtonSize.M,
            onGeolocationUpdated: (geolocation) =>
                parentState?.selectedGeolocation = geolocation,
            initialGeolocation: parentState?.selectedGeolocation,
          ),
        ],
      ),
    );
  }
}
