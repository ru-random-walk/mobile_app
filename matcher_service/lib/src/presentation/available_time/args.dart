import 'package:matcher_service/src/domain/entity/meeting_info/base.dart';

sealed class AvailableTimePageMode {
  const AvailableTimePageMode();
}

class AvailableTimePageModeAdd extends AvailableTimePageMode {
  const AvailableTimePageModeAdd();
}

class AvailableTimePageModeUpdate extends AvailableTimePageMode {
  final AvailableTimeEntity entity;

  const AvailableTimePageModeUpdate(this.entity);
}
