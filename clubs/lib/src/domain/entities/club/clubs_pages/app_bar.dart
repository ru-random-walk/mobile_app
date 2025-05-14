part of 'administrator/admin_page.dart';

class ClubAdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ClubApiService apiService; 
  final String clubId;

  const ClubAdminAppBar({
    super.key,
    required this.apiService,
    required this.clubId,
  });

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
                  final renderBox = context.findRenderObject()! as RenderBox;
                  final dy = renderBox.localToGlobal(Offset.zero).dy + renderBox.size.height;
                  late final OverlayEntry overlay;
                  overlay = OverlayEntry(
                    builder: (_) => TapRegion(
                      onTapOutside: (_) {
                        overlay.remove();
                        overlay.dispose();
                      },
                      child: ClubAdminMenu(
                        dY: dy,
                        closeMenu: () {
                          overlay.remove();
                          overlay.dispose();
                        },
                        onEdit: () {
                          debugPrint('Edit tapped');
                          overlay.remove();
                          overlay.dispose();
                        },
                        onDelete: () async {
                          await removeClub(clubId: clubId, apiService: apiService);
                          overlay.remove();
                          overlay.dispose();
                          Navigator.of(context).pop(); // Уходим с экрана
                        },
                        clubId: clubId,
                        apiService: apiService,
                      ),
                    ),
                  );

                  Overlay.of(context).insert(overlay);
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