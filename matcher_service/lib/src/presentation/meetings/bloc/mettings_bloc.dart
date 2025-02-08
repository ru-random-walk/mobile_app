import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'mettings_event.dart';
part 'mettings_state.dart';

class MettingsBloc extends Bloc<MettingsEvent, MettingsState> {
  MettingsBloc() : super(MettingsInitial()) {
    on<MettingsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
