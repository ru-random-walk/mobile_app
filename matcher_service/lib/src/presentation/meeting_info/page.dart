import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:matcher_service/src/domain/entity/meeting_info/status.dart';
import 'package:matcher_service/src/domain/usecase/appointment/get_details.dart';
import 'package:matcher_service/src/presentation/meeting_info/args.dart';
import 'package:matcher_service/src/presentation/meeting_info/bloc/meeting_info_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ui_utils/ui_utils.dart';

import '../../domain/entity/meeting_info/base.dart';

part 'widgets/app_bar.dart';
part 'widgets/date.dart';
part 'widgets/status.dart';
part 'widgets/time.dart';
part 'widgets/place.dart';
part 'widgets/map_preview.dart';
part 'widgets/body_data.dart';
part 'widgets/body.dart';

class MeetingInfoPage extends StatelessWidget {
  final MeetingInfoArgs args;

  const MeetingInfoPage({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return switch (state) {
          ProfileLoading() => throw UnimplementedError(),
          ProfileData() => Provider(
              create: (_) => GetAppointmentDetailsUseCase(state.user.id),
              child: BlocProvider(
                create: (context) => MeetingInfoBloc(
                  args,
                  context.read(),
                ),
                child: ColoredBox(
                  color: context.colors.base_0,
                  child: const SafeArea(
                    child: Scaffold(
                      appBar: _MeetingInfoAppBar(),
                      body: _MeetingInfoBodyWidget(),
                    ),
                  ),
                ),
              ),
            ),
          ProfileError() => throw UnimplementedError(),
          ProfileInvalidRefreshToken() => throw UnimplementedError(),
        };
      },
    );
  }
}
