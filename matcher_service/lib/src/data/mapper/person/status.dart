import 'package:matcher_service/src/domain/entity/meeting_info/status.dart';

const _valuesMap = <String?, MeetingStatus>{
  null: MeetingStatus.searching,
  'REQUESTED': MeetingStatus.requested,
  'APPOINTED': MeetingStatus.find,
  'IN_PROGRESS': MeetingStatus.inProcess,
  'DONE': MeetingStatus.done,
  'CANCELED': MeetingStatus.canceled,
};

extension AppointmetStatusMapper on String? {
  MeetingStatus toAppointmentStatus() {
    return _valuesMap[this] ?? MeetingStatus.searching;
  }
}
