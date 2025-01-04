part of '../page.dart';

class _MapPointerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 40.toFigmaSize,
      ),
      child: SizedBox.square(
        dimension: 60.toFigmaSize,
        child: SvgPicture.asset('packages/chats/assets/icons/place_fill.svg'),
      ),
    );
  }
}
