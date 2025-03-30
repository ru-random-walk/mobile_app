import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matcher_service/src/domain/usecase/available_time/add.dart';
import 'package:provider/provider.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';

import '../../domain/entity/available_time/modify.dart';
import 'args.dart';
import 'bloc/available_time_bloc.dart';

part 'widgets/body/body.dart';
part 'widgets/body/date.dart';
part 'widgets/body/time.dart';
part 'widgets/body/geoolocation.dart';
part 'widgets/button.dart';
part 'widgets/app_bar.dart';

class AvailableTimePage extends StatelessWidget {
  final AvailableTimePageMode pageMode;

  const AvailableTimePage({super.key, required this.pageMode});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => AddAvailableTimeUseCase(
            context.read(),
          ),
        ),
      ],
      child: BlocProvider(
        create: (context) => AvailableTimeBloc(
          context.read(),
          context.read(),
          pageMode,
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
                child: _AvailableTimeBodyWidget(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
