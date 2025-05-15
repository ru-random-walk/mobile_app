part of 'administrator/admin_page.dart';

class ClubAdminAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String description;
  final List<Map<String, dynamic>> approvement;
  final String clubId;
  final ClubApiService apiService;

  const ClubAdminAppBar({
    super.key,
    required this.title,
    required this.description,
    required this.approvement,
    required this.clubId,
    required this.apiService,
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
                          Navigator.of(context).pop();
                        },
                        clubId: clubId,
                        apiService: apiService,
                        title:title,
                        description: description,
                        approvement: approvement,
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