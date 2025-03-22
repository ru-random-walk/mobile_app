import 'package:matcher_service/src/domain/entity/meeting_info/status.dart';

const _valuesMap = <String?, MeetingStatus>{
  'requested': MeetingStatus.searching,
  'appointed': MeetingStatus.find,
  'in_progress': MeetingStatus.inProcess,
  'done': MeetingStatus.done,
  'canceled': MeetingStatus.canceled,
  null: MeetingStatus.searching,
};

extension AppointmetStatusMapper on String? {
  MeetingStatus toAppointmentStatus() {
    return _valuesMap[this] ?? MeetingStatus.searching;
  }
}
