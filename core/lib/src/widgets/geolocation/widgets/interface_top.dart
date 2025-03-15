part of '../page.dart';

class _MapInterfaceTopWidget extends StatelessWidget {
  const _MapInterfaceTopWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(
          flex: 2,
          child: SizedBox.shrink(),
        ),
        Expanded(
          flex: 6,
          child: _PickedMapAddress(),
        ),
        Expanded(
          flex: 2,
          child: _CloseMapButton(),
        ),
      ],
    );
  }
}
