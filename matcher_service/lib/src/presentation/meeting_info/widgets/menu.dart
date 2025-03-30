part of '../page.dart';

class _MeetingInfoMenuWidget extends StatelessWidget {
  final double dY;

  const _MeetingInfoMenuWidget(this.dY);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeetingInfoBloc, MeetingInfoState>(
      builder: (context, state) {
        return CustomSingleChildLayout(
          delegate: _MenuLayoutDelegate(dY),
          child: SizedBox(
            height: 200.toFigmaSize,
            width: 150.toFigmaSize,
            child: const ColoredBox(
              color: Colors.red,
            ),
          ),
        );
      },
    );
  }
}

class _MenuLayoutDelegate extends SingleChildLayoutDelegate {
  final double dY;

  const _MenuLayoutDelegate(this.dY);

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(
        Size(constraints.maxWidth, constraints.maxHeight));
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final dx = size.width - 10.toFigmaSize - childSize.width;
    return Offset(dx, dY);
  }

  @override
  bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) => false;
}
