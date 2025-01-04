part of '../../page.dart';

class _CloseMapButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.all(4.toFigmaSize),
        child: _BaseMapInterfaceButton(
          child: SizedBox.square(
            dimension: 16.toFigmaSize,
            child: CustomPaint(
              painter: CrossPaint(),
            ),
          ),
        ),
      ),
    );
  }
}
