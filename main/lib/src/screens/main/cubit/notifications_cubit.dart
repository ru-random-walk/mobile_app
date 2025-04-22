import 'package:bloc/bloc.dart';
import 'package:main/src/notification/manager.dart';
import 'package:meta/meta.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final notificationManager = NotificationManager();

  NotificationsCubit() : super(NotificationsInitial()) {
    init();
  }

  void init() {
    notificationManager.init();
  }
}
