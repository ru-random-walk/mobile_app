import 'package:bloc/bloc.dart';
import 'package:matcher_service/src/data/model/availabel_time.dart';
import 'package:meta/meta.dart';

part 'available_time_event.dart';
part 'available_time_state.dart';

class AvailableTimeBloc extends Bloc<AvailableTimeAdd, AvailableTimeState> {
  AvailableTimeBloc() : super(Idle()) {
    on<AvailableTimeAdd>((event, emit) {
      // TODO: implement event handler
    });
  }
}
