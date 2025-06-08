import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:main/src/notification/manager.dart';
import 'package:main/src/notification/push_data/push_data.dart';
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
