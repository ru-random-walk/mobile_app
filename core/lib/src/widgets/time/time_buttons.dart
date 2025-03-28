part of 'time_picker.dart';

class _SpecficTimePickButtonsGroup extends StatelessWidget {
  final VoidCallback? on9Tap;
  final VoidCallback? on12Tap;
  final VoidCallback? on15Tap;
  final VoidCallback? on18Tap;

  const _SpecficTimePickButtonsGroup({
    this.on9Tap,
    this.on12Tap,
    this.on15Tap,
    this.on18Tap,
  });

  @override
  Widget build(BuildContext context) {
    final spacer = SizedBox(width: 8.toFigmaSize);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SpecficValuePickBaseButton(
          title: '09:00',
          onTap: on9Tap,
        ),
        spacer,
        SpecficValuePickBaseButton(
          title: '12:00',
          onTap: on12Tap,
        ),
        spacer,
        SpecficValuePickBaseButton(
          title: '15:00',
          onTap: on15Tap,
        ),
        spacer,
        SpecficValuePickBaseButton(
          title: '18:00',
          onTap: on18Tap,
        ),
      ],
    );
  }
}
