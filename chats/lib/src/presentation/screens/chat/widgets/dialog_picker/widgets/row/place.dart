part of '../../../../page.dart';

class _PickMeetPlaceRow extends StatefulWidget {
  @override
  State<_PickMeetPlaceRow> createState() => _PickMeetPlaceRowState();
}

class _PickMeetPlaceRowState extends State<_PickMeetPlaceRow> {
  Geolocation? selectedPlace;

  @override
  Widget build(BuildContext context) {
    return _MeetDataRowWidget(
      title: 'Место',
      button: _MeetDataPickButton(
        title: selectedPlace?.toString() ?? 'Не выбрано',
        icon: SvgPicture.asset(
          'packages/chats/assets/icons/place.svg',
        ),
        onTap: () async {
          final res = await showGeolocationPicker(
            context: context,
            initialGeolocation: selectedPlace,
          );
          if (res is Geolocation && context.mounted) {
            updateGeo(res, context);
          }
        },
      ),
    );
  }

  void updateGeo(Geolocation geo, BuildContext context) {
    setState(() {
      selectedPlace = geo;
    });
    final parentState =
        context.findAncestorStateOfType<_MeetDataDialogWidgetState>();
    parentState?.geolocation = geo;
  }
}
