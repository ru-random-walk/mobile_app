part of '../page.dart';

class ClubsScreen extends StatelessWidget {
  final String currentUserId;

  const ClubsScreen({super.key, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _ClubsListAppBar(),
      floatingActionButton: AddClubButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => ClubFormScreen()),
          );
          if (result == true) {
            context.read<ClubsListBloc>().add(LoadClubsEvent());
          }
        },
      ),
      body: ClubsBody(currentUserId: currentUserId),
    );
  }
}
