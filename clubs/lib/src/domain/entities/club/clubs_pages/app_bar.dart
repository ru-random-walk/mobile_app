part of 'administrator/admin_page.dart';

class ClubAdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ClubAdminAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: preferredSize.height,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            IconButton(
              iconSize: 24.toFigmaSize,
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
            ),
            const Spacer(),
            Builder(builder: (context) {
              return IconButton(
                iconSize: 28.toFigmaSize,
                icon: const Icon(Icons.more_vert_outlined),
                onPressed: () {
                  final renderBox = context.findRenderObject() as RenderBox;
                  final offset = renderBox.localToGlobal(Offset.zero);
                  // final overlay = OverlayEntry(
                  //   builder: (_) => Stack(
                  //     children: [
                  //       Positioned.fill(
                  //         child: GestureDetector(
                  //           onTap: () {
                  //             overlay.remove();
                  //           },
                  //           child: Container(
                  //             color: Colors.transparent,
                  //           ),
                  //         ),
                  //       ),
                  //       Positioned(
                  //         top: offset.dy + renderBox.size.height,
                  //         right: 16,
                  //         child: Material(
                  //           elevation: 4,
                  //           borderRadius: BorderRadius.circular(8),
                  //           child: SizedBox(
                  //             width: 180,
                  //             child: _MeetingInfoMenuWidget(
                  //               closeMenu: () => overlay.remove(),
                  //               onModify: (modify) {
                  //                 // тут можно вызвать callback или event
                  //                 overlay.remove();
                  //                 print('Modify: $modify');
                  //               },
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // );

                  //Overlay.of(context).insert(overlay);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.toFigmaSize);
}
