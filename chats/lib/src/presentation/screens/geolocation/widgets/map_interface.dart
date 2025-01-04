part of '../page.dart';

class _MapInterfaceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(
          16.toFigmaSize,
        ),
        child: Column(
          children: [
            Expanded(
              child: _CloseMapButton(),
            ),
            Expanded(
              child: _ZoomMapButtons(),
            ),
            Expanded(
              child: _ZoomToCurrentLocationButton(),
            ),
            PickerConfirmButton(),
          ],
        ),
      ),
    );
  }
}
