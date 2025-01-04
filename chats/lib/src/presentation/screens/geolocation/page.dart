import 'package:chats/src/presentation/screens/geolocation/bloc/geolocation_bloc.dart';
import 'package:chats/src/presentation/shared/confirm_button.dart';
import 'package:chats/src/presentation/shared/cross_paint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

part 'widgets/map.dart';
part 'widgets/map_interface.dart';
part 'widgets/buttons/current_location.dart';
part 'widgets/buttons/zoom.dart';
part 'widgets/buttons/close.dart';
part 'widgets/buttons/base.dart';
part 'widgets/map_pointer.dart';

class PickGeolocationPage extends StatelessWidget {
  const PickGeolocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GeolocationBloc(),
      child: Stack(
        children: [
          _MapWidget(),
          Center(
            child: _MapPointerWidget(),
          ),
          _MapInterfaceWidget(),
        ],
      ),
    );
  }
}
