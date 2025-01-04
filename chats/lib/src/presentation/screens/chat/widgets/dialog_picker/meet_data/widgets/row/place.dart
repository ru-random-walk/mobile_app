part of '../../../../../page.dart';

class _PickMeetPlaceRow extends StatefulWidget {
  @override
  State<_PickMeetPlaceRow> createState() => _PickMeetPlaceRowState();
}

class _PickMeetPlaceRowState extends State<_PickMeetPlaceRow> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return _MeetDataRowWidget(
      title: 'Место',
      button: _MeetDataPickButton(
        title: '23.03.2023',
        icon: SvgPicture.asset(
          'packages/chats/assets/icons/place.svg',
        ),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const PickGeolocationPage(),
          ),
        ),
      ),
    );
  }
}
