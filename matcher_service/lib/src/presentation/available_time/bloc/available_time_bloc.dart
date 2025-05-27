import 'package:clubs/clubs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcher_service/src/domain/usecase/available_time/add.dart';
import 'package:matcher_service/src/domain/usecase/available_time/update.dart';
import 'package:matcher_service/src/domain/usecase/person/get_clubs.dart';
import 'package:matcher_service/src/presentation/available_time/args.dart';

import '../../../domain/entity/available_time/modify.dart';

part 'available_time_event.dart';
part 'available_time_state.dart';

class AvailableTimeBloc extends Bloc<AvailableTimeEvent, AvailableTimeState> {
  final AddAvailableTimeUseCase _addAvailableTimeUseCase;
  final UpdateAvailableTimeUseCase _updateAvailableTimeUseCase;
  final GetPersonClubsUseCase _getPersonClubsUseCase;
  final String userId;
  final AvailableTimePageMode mode;

  AvailableTimeBloc(
    this._addAvailableTimeUseCase,
    this._updateAvailableTimeUseCase,
    this.mode,
    this._getPersonClubsUseCase,
    this.userId,
  ) : super(AvailableTimeStateLoadingClubs()) {
    on<AvailableTimeAdd>((_onAddAvailableTime));
    on<_LoadPersonClubsEvent>((_onLoadPersonClubs));
    add(_LoadPersonClubsEvent());
  }

  void _onLoadPersonClubs(_LoadPersonClubsEvent event, Emitter emit) async {
    final res = await _getPersonClubsUseCase(userId);
    res.fold((e) {
      emit(Idle(const []));
    }, (clubs) {
      emit(Idle(clubs));
    });
  }

  void _onAddAvailableTime(AvailableTimeAdd event, Emitter emit) async {
    final curState = state as AvailableTimeStateClubsResult;
    emit(AvailableTimeCreatingLoading(curState.clubs));
    final useCase = switch (mode) {
      AvailableTimePageModeAdd _ => _addAvailableTimeUseCase.call,
      AvailableTimePageModeUpdate updateMode =>
        (AvailableTimeModifyEntity modify) => _updateAvailableTimeUseCase(
              UpdateAvailableTimeArgs(
                id: updateMode.entity.id,
                modifyEntity: modify,
              ),
            ),
    };
    final res = await useCase(event.availabelTime);
    res.fold((e) {
      switch (mode) {
        case AvailableTimePageModeAdd():
          emit(AvailableTimeCreatingError(curState.clubs));
        case AvailableTimePageModeUpdate():
          emit(AvailableTimeUpdateError(curState.clubs));
      }
    }, (_) {
      switch (mode) {
        case AvailableTimePageModeAdd():
          emit(AvailableTimeCreatingSuccess(curState.clubs));
        case AvailableTimePageModeUpdate():
          emit(AvailableTimeUpdateSucces(event.availabelTime, curState.clubs));
      }
    });
  }
}
