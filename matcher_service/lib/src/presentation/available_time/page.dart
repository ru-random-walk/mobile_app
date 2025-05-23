import 'package:auth/auth.dart';
import 'package:clubs/clubs.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcher_service/src/domain/usecase/available_time/add.dart';
import 'package:matcher_service/src/domain/usecase/available_time/update.dart';
import 'package:matcher_service/src/domain/usecase/person/get_clubs.dart';
import 'package:matcher_service/src/presentation/available_time/widgets/limited_wrap/limited_wrap.dart';
import 'package:provider/provider.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';

import '../../domain/entity/available_time/modify.dart';
import 'args.dart';
import 'bloc/available_time_bloc.dart';

part 'widgets/body/body.dart';
part 'widgets/body/date.dart';
part 'widgets/body/time.dart';
part 'widgets/body/clubs.dart';
part 'widgets/body/geoolocation.dart';
part 'widgets/button.dart';
part 'widgets/app_bar.dart';

class AvailableTimePage extends StatelessWidget {
  final AvailableTimePageMode pageMode;

  const AvailableTimePage({super.key, required this.pageMode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return switch (state) {
          ProfileLoading _ => const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          // TODO: Handle this case.
          ProfileData data => MultiProvider(
              providers: [
                Provider(
                  create: (_) => AddAvailableTimeUseCase(
                    context.read(),
                  ),
                ),
                Provider(
                  create: (_) => UpdateAvailableTimeUseCase(
                    context.read(),
                  ),
                ),
                Provider(
                  create: (_) => GetPersonClubsUseCase(
                    context.read(),
                  ),
                )
              ],
              child: BlocProvider(
                create: (context) => AvailableTimeBloc(
                  context.read(),
                  context.read(),
                  pageMode,
                  context.read(),
                  data.user.id,
                ),
                child: ColoredBox(
                  color: context.colors.base_0,
                  child: SafeArea(
                    child: Scaffold(
                      appBar: const _AvailableTimePageAppBar(),
                      body: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 28.toFigmaSize,
                          vertical: 12.toFigmaSize,
                        ),
                        child: _AvailableTimeBodyWidget(
                          pageMode: pageMode,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          _ => const Center(
              child: Text('Произошла ошибка,'),
            ),
        };
      },
    );
  }
}
