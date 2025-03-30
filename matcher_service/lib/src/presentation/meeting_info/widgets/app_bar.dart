part of '../page.dart';

class _MeetingInfoAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const _MeetingInfoAppBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          iconSize: 24.toFigmaSize,
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        const Spacer(),
        Builder(builder: (context) {
          return IconButton(
            iconSize: 28.toFigmaSize,
            icon: const Icon(
              Icons.more_vert_outlined,
            ),
            onPressed: () {
              final renderObject = context.findRenderObject()! as RenderBox;
              final dy =
                  renderObject.localToGlobal(Offset.zero).dy + 2.toFigmaSize;
              final height = renderObject.size.height;
              late final OverlayEntry overlay;
              overlay = OverlayEntry(
                builder: (_) => TapRegion(
                  child: _MeetingInfoMenuWidget(dy + height),
                  onTapOutside: (event) {
                    overlay.remove();
                    overlay.dispose();
                  },
                ),
              );
              Overlay.of(context).insert(overlay);
            },
          );
        })
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.toFigmaSize);
}
