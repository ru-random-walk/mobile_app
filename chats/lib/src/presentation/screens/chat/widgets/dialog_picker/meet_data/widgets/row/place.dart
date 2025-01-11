part of '../../../../../page.dart';

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
          final res = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => PickGeolocationPage(
                initialGeolocation: selectedPlace,
              ),
            ),
          );
          if (res != null && res is Geolocation) {
            setState(() {
              selectedPlace = res;
            });
          }
        },
      ),
    );
  }
}
