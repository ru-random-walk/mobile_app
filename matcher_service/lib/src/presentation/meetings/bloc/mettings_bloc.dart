import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/list.dart';
import 'package:utils/utils.dart';

import '../../../domain/usecase/person/get_schedule.dart';

part 'mettings_event.dart';
part 'mettings_state.dart';

class MettingsBloc extends Bloc<MettingsEvent, MettingsState> {
  final GetScheduleUseCase _getScheduleUseCase;

  late final StreamSubscription<Either<BaseError, List<MeetingsForDayEntity>>>
      _subscription;

  MettingsBloc(this._getScheduleUseCase) : super(MettingsLoading()) {
    _subscription = _getScheduleUseCase.userScheduleStream.listen((data) => add(
          _MeetingsDataArrivedEvent(data),
        ));
    on<GetMettingsEvent>((_, __) => _getScheduleUseCase());
    on<_MeetingsDataArrivedEvent>(
      (event, emit) => emit(
        _handleFetchedData(event.data),
      ),
    );
  }

  MettingsState _handleFetchedData(
    Either<BaseError, List<MeetingsForDayEntity>> data,
  ) =>
      switch (data) {
        Left<BaseError, List<MeetingsForDayEntity>> val =>
          MettingsError(error: val.leftValue),
        Right<BaseError, List<MeetingsForDayEntity>> val =>
          val.rightValue.isEmpty
              ? MettingsEmpty()
              : MettingsData(meetings: val.rightValue),
      };

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
