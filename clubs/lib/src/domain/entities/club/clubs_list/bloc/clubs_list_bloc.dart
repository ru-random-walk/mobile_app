import 'package:bloc/bloc.dart';
import 'package:clubs/src/domain/entities/club/clubs_list/get_clubs_use_case.dart';

sealed class ClubsEvent {}

class LoadClubsEvent extends ClubsEvent {}

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
  }
}
