import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcher_service/src/domain/usecase/available_time/add.dart';
import 'package:matcher_service/src/domain/usecase/available_time/update.dart';
import 'package:matcher_service/src/presentation/available_time/args.dart';

import '../../../domain/entity/available_time/modify.dart';

part 'available_time_event.dart';
part 'available_time_state.dart';

class AvailableTimeBloc extends Bloc<AvailableTimeAdd, AvailableTimeState> {
  final AddAvailableTimeUseCase _addAvailableTimeUseCase;
  final UpdateAvailableTimeUseCase _updateAvailableTimeUseCase;
  final AvailableTimePageMode mode;

  AvailableTimeBloc(
    this._addAvailableTimeUseCase,
    this._updateAvailableTimeUseCase,
    this.mode,
  ) : super(Idle()) {
    on<AvailableTimeAdd>((_onAddAvailableTime));
  }

  void _onAddAvailableTime(AvailableTimeAdd event, Emitter emit) async {
    emit(AvailableTimeCreatingLoading());
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
          emit(AvailableTimeCreatingError());
        case AvailableTimePageModeUpdate():
          emit(AvailableTimeUpdateError());
      }
    }, (_) {
      switch (mode) {
        case AvailableTimePageModeAdd():
          emit(AvailableTimeCreatingSuccess());
        case AvailableTimePageModeUpdate():
          emit(AvailableTimeUpdateSucces(event.availabelTime));
      }
    });
  }
}
