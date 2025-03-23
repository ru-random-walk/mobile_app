import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/base.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/list.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/preview.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/status.dart';
import 'package:matcher_service/src/domain/usecase/person/get_schedule.dart';
import 'package:matcher_service/src/presentation/available_time/page.dart';
import 'package:matcher_service/src/presentation/meeting_info/args.dart';
import 'package:matcher_service/src/presentation/meeting_info/page.dart';
import 'package:matcher_service/src/presentation/meetings/bloc/mettings_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';

import 'widgets/card/color_mode.dart';

part 'widgets/app_bar.dart';
part 'widgets/card/meeting_info.dart';
part 'widgets/card/mettings_for_day.dart';
part 'widgets/card/meetings_day.dart';
part 'widgets/body_data.dart';
part 'widgets/add_button.dart';
part 'widgets/body.dart';
part 'widgets/body_empty.dart';

class MatcherPage extends StatefulWidget {
  const MatcherPage({super.key});

  @override
  State<MatcherPage> createState() => _MatcherPageState();
}

class _MatcherPageState extends State<MatcherPage> {
  Future<void> addAvailableTime() async {
    final res = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const AvailableTimePage(),
      ),
    );
    if (res != null && mounted) {
      context.read<MettingsBloc>().add(GetMettingsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => GetScheduleUseCase(),
      child: BlocProvider(
        create: (context) => MettingsBloc(
          context.read(),
        )..add(GetMettingsEvent()),
        child: const Scaffold(
          appBar: _MeetingsAppBar(),
          body: _MeetingsBody(),
          floatingActionButton: _AddMeetingButton(),
        ),
      ),
    );
  }
}
