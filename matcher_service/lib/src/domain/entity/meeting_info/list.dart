import 'package:matcher_service/src/domain/entity/meeting_info/preview.dart';

class MeetingsForDayEntity {
  final DateTime date;
  final List<MeetingPreviewInfoEntity> meetings;

  MeetingsForDayEntity({required this.date, required this.meetings});
}
