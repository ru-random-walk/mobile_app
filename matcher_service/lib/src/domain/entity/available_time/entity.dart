// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../meeting_info/base.dart';

class AvailableTimeEntity extends BaseMeetingEntity {
  @override
  final DateTime date;
  @override
  final TimeOfDay timeStart;
  @override
  final TimeOfDay timeEnd;
  @override
  final Geolocation location;
  @override
  final List<ShortClubEntity> clubs;

  AvailableTimeEntity({
    required super.id,
    required super.status,
    required this.date,
    required this.timeStart,
    required this.timeEnd,
    required this.location,
    required this.clubs,
  });

  AvailableTimeEntity copyWith({
    required AvailableTimeModifyEntity newEntity,
  }) {
    return AvailableTimeEntity(
      id: id,
      status: status,
      date: newEntity.date,
      timeStart: newEntity.timeStart,
      timeEnd: newEntity.timeEnd,
      location: newEntity.location,
      clubs: newEntity.clubs,
    );
  }
}
