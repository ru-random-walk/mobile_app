part of '../../../../page.dart';

class _MeetPickDataDialogCloseButton extends StatelessWidget {
  @override
  Widget build(Object context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(
          right: 8.toFigmaSize,
          bottom: 4.toFigmaSize,
          top: 8.toFigmaSize,
        ),
        child: DialogPickerHeaderCloseButton(),
      ),
    );
  }
}
