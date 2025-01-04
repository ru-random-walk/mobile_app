part of '../../page.dart';

class _ZoomToCurrentLocationButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(
          bottom: 20.toFigmaSize,
        ),
        child: _BaseMapInterfaceButton(
          padding: EdgeInsets.symmetric(
            vertical: 12.toFigmaSize,
            horizontal: 14.toFigmaSize,
          ),
          child: SizedBox.square(
            dimension: 24.toFigmaSize,
            child: SvgPicture.asset('packages/chats/assets/icons/gps.svg'),
          ),
        ),
      ),
    );
  }
}
