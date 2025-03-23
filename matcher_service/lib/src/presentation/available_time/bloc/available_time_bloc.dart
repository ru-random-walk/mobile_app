import 'package:bloc/bloc.dart';
import 'package:matcher_service/src/domain/usecase/available_time/add.dart';
import 'package:meta/meta.dart';

import '../../../domain/entity/available_time/modify.dart';

part 'available_time_event.dart';
part 'available_time_state.dart';

class AvailableTimeBloc extends Bloc<AvailableTimeAdd, AvailableTimeState> {
  final AddAvailableTimeUseCase _addAvailableTimeUseCase;

  AvailableTimeBloc(this._addAvailableTimeUseCase) : super(Idle()) {
    on<AvailableTimeAdd>((_onAddAvailableTime));
  }

  void _onAddAvailableTime(AvailableTimeAdd event, Emitter emit) async {
    emit(AvailableTimeCreatingLoading());
    final res = await _addAvailableTimeUseCase(event.availabelTime);
    res.fold((e) {
      emit(AvailableTimeCreatingError());
    }, (_) {
      emit(AvailableTimeCreatingSuccess());
    });
  }
}
