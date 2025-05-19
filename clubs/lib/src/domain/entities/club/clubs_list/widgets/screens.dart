part of '../page.dart';

class ClubsScreen extends StatefulWidget {
  final String currentUserId;

  const ClubsScreen({super.key, required this.currentUserId});

  @override
  State<ClubsScreen> createState() => _ClubsScreenState();
}

class _ClubsScreenState extends State<ClubsScreen> {
  bool _isSearching = false;
  String _searchQuery = '';

  void _onSearchChanged(bool isSearching, String query) {
    setState(() {
      _isSearching = isSearching;
      _searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _ClubsListAppBar(onSearchChanged: _onSearchChanged),
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
      body: ClubsBody(
        currentUserId: widget.currentUserId,
        isSearching: _isSearching,),
    );
  }
}
