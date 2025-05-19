import 'package:bloc/bloc.dart';
import 'package:clubs/src/domain/entities/club/clubs_list/get_clubs_use_case.dart';

sealed class ClubsEvent {}

class LoadClubsEvent extends ClubsEvent {}

class SearchClubsEvent extends ClubsEvent {
  final String query;

  SearchClubsEvent({required this.query});
}

class LoadNextSearchPageEvent extends ClubsEvent {}

sealed class ClubsState {}

class ClubsInitial extends ClubsState {}

class ClubsLoading extends ClubsState {}

class ClubsLoaded extends ClubsState {
  final List<Map<String, dynamic>> groups;
  ClubsLoaded(this.groups);
}

class ClubsError extends ClubsState {}

class ClubsListBloc extends Bloc<ClubsEvent, ClubsState> {
  final GetClubsUseCase getGroups;
  int _currentPage = 0;
  final int _pageSize = 20;
  String _lastQuery = '';
  bool _isLoadingNextPage = false;
  List<Map<String, dynamic>> _loadedGroups = [];

  ClubsListBloc(this.getGroups) : super(ClubsInitial()) {
    on<LoadClubsEvent>((event, emit) async {
      emit(ClubsLoading());
      try {
        final groups = await getGroups.getClubs();
        emit(ClubsLoaded(groups));
      } catch (e) {
        emit(ClubsError());
      }
    });

    on<SearchClubsEvent>((event, emit) async {
      emit(ClubsLoading());
      try {
        _currentPage = 0;
        _lastQuery = event.query;
        _loadedGroups = await getGroups.getSearchedClubs(
          query: event.query,
          page: _currentPage,
          size: _pageSize,
        );
        emit(ClubsLoaded(List.from(_loadedGroups)));
      } catch (e) {
        emit(ClubsError());
      }
    });

    on<LoadNextSearchPageEvent>((event, emit) async {
      if (_isLoadingNextPage) return;
      _isLoadingNextPage = true;
      try {
        _currentPage += 1;
        final nextPageGroups = await getGroups.getSearchedClubs(
          query: _lastQuery,
          page: _currentPage,
          size: _pageSize,
        );
        if (nextPageGroups.isNotEmpty) {
          _loadedGroups.addAll(nextPageGroups);
          emit(ClubsLoaded(List.from(_loadedGroups)));
        }
      } catch (_) {
        emit(ClubsError());
      } finally {
        _isLoadingNextPage = false;
      }
    });
  }
}
