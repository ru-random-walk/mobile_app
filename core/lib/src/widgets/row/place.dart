part of 'widgets.dart';

class PickMeetPlaceButton extends StatefulWidget {
  final ButtonSize size;
  final double? width;
  final void Function(Geolocation geolocation) onGeolocationUpdated;

  const PickMeetPlaceButton({
    super.key,
    required this.onGeolocationUpdated,
    required this.size,
    this.width,
  });

  @override
  State<PickMeetPlaceButton> createState() => _PickMeetPlaceButtonState();
}

class _PickMeetPlaceButtonState extends State<PickMeetPlaceButton> {
  Geolocation? selectedPlace;

  @override
  Widget build(BuildContext context) {
    return _MeetDataPickButton(
      width: widget.width,
      size: widget.size,
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
    );
  }

  void updateGeo(Geolocation geo, BuildContext context) {
    setState(() {
      selectedPlace = geo;
      widget.onGeolocationUpdated(geo);
    });
  }
}
