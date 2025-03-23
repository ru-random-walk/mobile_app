import 'package:bloc/bloc.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/base.dart';
import 'package:matcher_service/src/domain/usecase/appointment/get_details.dart';
import 'package:matcher_service/src/presentation/meeting_info/args.dart';
import 'package:meta/meta.dart';

part 'meeting_info_event.dart';
part 'meeting_info_state.dart';

class MeetingInfoBloc extends Bloc<MeetingInfoEvent, MeetingInfoState> {
  final String? appointmentId;
  final GetAppointmentDetailsUseCase _getAppointmentDetailsUseCase;

  MeetingInfoBloc(MeetingInfoArgs args, this._getAppointmentDetailsUseCase)
      : appointmentId = args is AppointmentIdArgs ? args.id : null,
        super(switch (args) {
          AppointmentIdArgs _ => AppointmentInfoLoading(),
          final AvailableTimeInfoArgs arg => AvailableTimeInfo(
              arg.availableTime,
            ),
        }) {
    if (appointmentId != null) {
      add(LoadAppointmentInfo());
    }
    on<LoadAppointmentInfo>(_onLoadAppointmentInfo);
  }

  Future<void> _onLoadAppointmentInfo(
    LoadAppointmentInfo event,
    Emitter emit,
  ) async {
    final res = await _getAppointmentDetailsUseCase(appointmentId!);
    res.fold((e) {
      emit(AppointmentInfoError());
    }, (data) {
      emit(AppointmentInfoSuccess(data));
    });
  }
}
