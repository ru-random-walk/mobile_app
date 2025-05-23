import 'package:matcher_service/src/domain/entity/meeting_info/base.dart';

sealed class AvailableTimePageMode {
  const AvailableTimePageMode();
}

class AvailableTimePageModeAdd extends AvailableTimePageMode {
  // final bool canUseClubsFiltering;

  const AvailableTimePageModeAdd(
    // {required this.canUseClubsFiltering,}
    );
}

class AvailableTimePageModeUpdate extends AvailableTimePageMode {
  final AvailableTimeEntity entity;

  const AvailableTimePageModeUpdate(this.entity);
}
