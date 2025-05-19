part of '../../../page.dart';

class ClubsBody extends StatefulWidget {
  final String currentUserId;
  final bool isSearching;

  const ClubsBody({
    super.key, 
    required this.currentUserId,
    this.isSearching = false,
  });

  @override
  State<ClubsBody> createState() => _ClubsBodyState();
}

class _ClubsBodyState extends State<ClubsBody> {
  final controller = ClubsBodyController();

  @override
  void initState() {
    super.initState();
    controller.init(widget, context);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ClubsBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isSearching != widget.isSearching) {
      controller.dispose();
      controller.init(widget, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return controller.buildWith(
      context: context,
      onFilterChanged: (index) => setState(() => controller.selectedFilterIndex = index),
    );
  }
}