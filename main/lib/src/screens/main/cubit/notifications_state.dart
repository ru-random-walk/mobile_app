part of 'notifications_cubit.dart';

@immutable
sealed class NotificationsState {}

final class NotificationsInitial extends NotificationsState {}

final class NotificationArrived extends NotificationsState {
  final PushData data;
  NotificationArrived(this.data);
}
