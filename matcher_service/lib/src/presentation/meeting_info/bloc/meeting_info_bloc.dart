import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:matcher_service/src/domain/entity/available_time/modify.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/base.dart';
import 'package:matcher_service/src/domain/usecase/appointment/cancel.dart';
import 'package:matcher_service/src/domain/usecase/appointment/get_details.dart';
import 'package:matcher_service/src/domain/usecase/available_time/delete.dart';
import 'package:matcher_service/src/presentation/meeting_info/args.dart';
import 'package:meta/meta.dart';
import 'package:utils/utils.dart';

part 'meeting_info_event.dart';
part 'meeting_info_state.dart';

class MeetingInfoBloc extends Bloc<MeetingInfoEvent, MeetingInfoState> {
  final String? appointmentId;
  final GetAppointmentDetailsUseCase _getAppointmentDetailsUseCase;
  final DeleteAvailableTimeUseCase _deleteAvailableTimeUseCase;
  final CancelAppointmentUseCase _cancelAppointmentUseCase;

  MeetingInfoBloc(
    MeetingInfoArgs args,
    this._getAppointmentDetailsUseCase,
    this._deleteAvailableTimeUseCase,
    this._cancelAppointmentUseCase,
  )   : appointmentId = args is AppointmentIdArgs ? args.id : null,
        super(switch (args) {
          AppointmentIdArgs _ => AppointmentInfoLoading(),
          final AvailableTimeInfoArgs arg => AvailableTimeInfo(
              arg.availableTime,
            ),
        }) {
    on<LoadAppointmentInfo>(_onLoadAppointmentInfo);
    on<UpdateAvailableTime>(_onUpdateAvailableTime);
    on<DeleteMeeting>(_onDeleteMeeting);
    if (appointmentId != null) {
      add(LoadAppointmentInfo());
    }
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

  Future<void> _onUpdateAvailableTime(
    UpdateAvailableTime event,
    Emitter emit,
  ) async {
    final localState = state;
    assert(localState is AvailableTimeInfo);
    if (localState is AvailableTimeInfo) {
      emit(
        AvailableTimeInfo(
          localState.availableTime.copyWith(
            newEntity: event.updateEntity,
          ),
        ),
      );
    }
  }

  Future<void> _onDeleteMeeting(
    DeleteMeeting _,
    Emitter emit,
  ) async {
    final deleteFunc = switch (state) {
      AppointmentInfoSuccess state => () =>
          _cancelAppointmentUseCase(state.appointment.id),
      AvailableTimeInfo state => () =>
          _deleteAvailableTimeUseCase(state.availableTime.id),
      _ => () => Future.value(
          Left(BaseError('Wrong state usage', StackTrace.current))),
    };
    final res = await deleteFunc();
    res.fold(
      (_) {
        switch (state) {
          case AppointmentInfoSuccess a:
            emit(AppointmentDeleteError(a.appointment));
          case AvailableTimeInfo at:
            emit(AvailableTimeDeleteError(at.availableTime));
          default:
        }
      },
      (_) {
        switch (state) {
          case AppointmentInfoSuccess a:
            emit(AppointmentDeleteSuccess(a.appointment));
          case AvailableTimeInfo at:
            emit(AvailableTimeDeleteSuccess(at.availableTime));
          default:
        }
      },
    );
  }
}
