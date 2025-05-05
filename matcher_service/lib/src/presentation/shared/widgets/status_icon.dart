import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/status.dart';
import 'package:ui_utils/ui_utils.dart';

class MeetingStatusIconWidget extends StatelessWidget {
  final MeetingStatus status;
  final double size;
  final Color color;

  const MeetingStatusIconWidget({
    super.key,
    required this.status,
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    const pathPrefix = 'packages/matcher_service/assets/icons';
    final iconName = switch (status) {
      MeetingStatus.inProcess => 'logo.svg',
      MeetingStatus.searching => 'search.svg',
      MeetingStatus.find => 'checked.svg',
      MeetingStatus.done => 'done.svg',
      MeetingStatus.canceled => 'cancel.svg',
      MeetingStatus.requested => 'requested.svg',
    };
    final iconPath = '$pathPrefix/$iconName';
    return Padding(
      padding: EdgeInsets.only(left: 8.toFigmaSize),
      child: SvgPicture.asset(
        iconPath,
        colorFilter: ColorFilter.mode(
          color,
          BlendMode.srcIn,
        ),
        width: size,
        height: size,
      ),
    );
  }
}
