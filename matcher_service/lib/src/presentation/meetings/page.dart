import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/entity.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/preview.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/status.dart';
import 'package:matcher_service/src/presentation/available_time/page.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';

import 'widgets/card/color_mode.dart';

part 'widgets/app_bar.dart';
part 'widgets/card/meeting_info.dart';
part 'widgets/card/mettings_for_day.dart';
part 'widgets/card/meetings_day.dart';
part 'widgets/body.dart';
part 'widgets/add_button.dart';

class MatcherPage extends StatelessWidget {
  const MatcherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _MeetingsAppBar(),
      body: _MeetingsBodyDataList(),
      floatingActionButton: _AddMeetingButton(),
    );
  }
}
