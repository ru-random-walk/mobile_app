part of '../page.dart';

class ClubsScreen extends StatefulWidget {
  final String currentUserId;

  const ClubsScreen({super.key, required this.currentUserId});

  @override
  State<ClubsScreen> createState() => _ClubsScreenState();
}

class _ClubsScreenState extends State<ClubsScreen> {
  void Function()? _toggleSearchExternal;
  bool _isSearching = false;

  void _onSearchChanged(bool isSearching, String query) {
    setState(() {
      _isSearching = isSearching;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _ClubsListAppBar(
        onSearchChanged: _onSearchChanged,
        onToggleSearchInit: (callback) {
          _toggleSearchExternal = callback;
        },
      ),
      floatingActionButton: AddClubButton(
        onPressed: () async {
          final bloc = context.read<ClubsListBloc>();
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ClubFormScreen()),
          );
          if (result == true) {
            bloc.add(LoadClubsEvent());
          }
        },
      ),
      body: ClubsBody(
        currentUserId: widget.currentUserId,
        isSearching: _isSearching,
        onFindGroup: () {
          _toggleSearchExternal?.call();
        }
      ),
    );
  }
}
