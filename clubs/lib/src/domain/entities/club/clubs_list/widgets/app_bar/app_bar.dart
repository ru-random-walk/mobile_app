part of '../../page.dart';

final _appBarHeight = 56.toFigmaSize;

class _ClubsListAppBar extends StatefulWidget implements PreferredSizeWidget {
  final void Function(void Function())? onToggleSearchInit;
  final void Function(bool isSearching, String query) onSearchChanged;

  const _ClubsListAppBar({super.key,required this.onSearchChanged, this.onToggleSearchInit});

  @override
  State<_ClubsListAppBar> createState() => _ClubsListAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(_appBarHeight);
}

class _ClubsListAppBarState extends State<_ClubsListAppBar> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        widget.onSearchChanged(false, '');
        context.read<ClubsListBloc>().add(LoadClubsEvent());
      }
    });
  }

  void _onSearchSubmitted(String query) {
    final query = _searchController.text.trim();
    widget.onSearchChanged(query.isNotEmpty, query);
    if (query.isNotEmpty) {
      context.read<ClubsListBloc>().add(SearchClubsEvent(query: query));
    } else {
      context.read<ClubsListBloc>().add(LoadClubsEvent());
    }
  }

  void _clearSearch() {
    _searchController.clear();
    widget.onSearchChanged(false, '');
    setState(() {
      _isSearching = false;
    });
    context.read<ClubsListBloc>().add(LoadClubsEvent());
  }

  @override
  void initState() {
    super.initState();
    widget.onToggleSearchInit?.call(_toggleSearch);
    _searchController.addListener(() {
      setState(() {});
    });
  }


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.toFigmaSize,
      ),
      child: Row(
        children: [
          Expanded(
            child:  _isSearching
                ? CustomTextField(
                    controller: _searchController,
                    hint: 'Поиск групп',
                    textStyle: context.textTheme.bodyMRegularBase90,
                    height: 24.toFigmaSize,
                    radius: 6.toFigmaSize,
                    maxLines: 1,
                    onSubmitted: _onSearchSubmitted,
                    suffix: GestureDetector(
                            onTap: _clearSearch,
                            child: Icon(Icons.close, color: context.colors.base_70),
                          )
                  )
                : Text(
                  'My Groups',
                  style: context.textTheme.h4.copyWith(
                    color: context.colors.base_90,
                  ),
                ),
                
          ),
          if (!_isSearching)...[
            SizedBox(width: 16.toFigmaSize),
          _SearchButton(onTap: _toggleSearch),
          ],
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_appBarHeight);
}
