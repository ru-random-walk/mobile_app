import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/list.dart';
import 'package:meta/meta.dart';

import '../../../domain/usecase/person/get_schedule.dart';

part 'mettings_event.dart';
part 'mettings_state.dart';

class MettingsBloc extends Bloc<MettingsEvent, MettingsState> {
  final GetScheduleUseCase _getScheduleUseCase;

  MettingsBloc(this._getScheduleUseCase) : super(MettingsLoading()) {
    on<GetMettingsEvent>((event, emit) async {
      final res = await _getScheduleUseCase();
      res.fold((e) {
        emit(MettingsError(error: e));
      }, (data) {
        if (data.isEmpty) {
          emit(MettingsEmpty());
        } else {
          emit(MettingsData(meetings: data));
        }
      });
    });
  }
}
