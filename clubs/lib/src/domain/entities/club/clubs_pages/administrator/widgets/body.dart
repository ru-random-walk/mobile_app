part of '../admin_page.dart';

class ClubAdminBody extends StatefulWidget {
  final String title;
  final String description;
  final List<Map<String, dynamic>> approvement;
  final String clubId;
  final ClubApiService apiService;

  const ClubAdminBody({
    super.key,
    required this.title,
    required this.description,
    required this.approvement,
    required this.clubId,
    required this.apiService,
  });

  @override
  State<ClubAdminBody> createState() => _ClubAdminBodyState();
}

class _ClubAdminBodyState extends State<ClubAdminBody> {
  final ScrollController _scrollController = ScrollController();

  bool _isLoading = true;      
  bool _isLoadingMore = false; 
  int _currentPage = 0;        
  final int _pageSize = 30;    
  List<UserEntity> _users = []; 
  bool _hasMore = true;        

  List<Map<String, dynamic>> _members = [];

  @override
  void initState() {
    super.initState();
    _fetchMembers(page: 0);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchMembers({int page = 0}) async {
    if (!_hasMore && page != 0) return;

    try {
      final newMembers = await getClubMembers(
        clubId: widget.clubId,
        page: page,
        size: _pageSize,
        apiService: widget.apiService,
      );

      final ids = newMembers.map((m) => m['id'] as String).toList();
      final result = await UsersDataSource().getUsers(PageQueryModel(page: 0, size: ids.length), ids);
      final newUsers = result.content.map((u) => u.toDomain()).toList();

      setState(() {
        if (page == 0) {
          _members = newMembers;
          _users = newUsers;
          _isLoading = false;
        } else {
          _members.addAll(newMembers);
          _users.addAll(newUsers);
          _isLoadingMore = false;
        }
        _currentPage = page;
        _hasMore = newMembers.length == _pageSize;
      });
    } catch (e) {
      print('Ошибка при загрузке участников: $e');
      setState(() {
        if (page == 0) {
          _isLoading = false;
        } else {
          _isLoadingMore = false;
        }
      });
    }
  }

  void _loadMore() {
    if (_isLoadingMore || !_hasMore) return;
    setState(() {
      _isLoadingMore = true;
    });
    _fetchMembers(page: _currentPage + 1);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      _loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    final itemCount = _users.length + 1 + (_isLoadingMore ? 1 : 0);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 4.toFigmaSize,
        horizontal: 20.toFigmaSize,
      ),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (index == 0) {
            return ClubHeader(
              title: widget.title,
              description: widget.description,
              approvement: widget.approvement,
              membersCount: _members.length,
            );
          }
          if (_isLoadingMore && index == itemCount - 1) {
            return const Center(child: CircularProgressIndicator());
          }
          final userIndex = index - 1;
          final user = _users[userIndex];
          final memberInfo = _members.firstWhere(
            (m) => m['id'] == user.id,
            orElse: () => {},
          );
          final role = memberInfo['role'] ?? 'Участник';
          return MemberTile(
            name: user.fullName,
            role: role,
            avatarPath: user.avatar,
            onMenuPressed: () {
            },
          );
        },
      ),
    );
  }
}
