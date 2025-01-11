import 'dart:async';

import 'package:chats/src/data/data_source/geocoder.dart';
import 'package:chats/src/data/repository/geocoder.dart';
import 'package:chats/src/domain/entity/meet_data/geolocation.dart';
import 'package:chats/src/domain/use_case/reverse_geocoding.dart';
import 'package:chats/src/presentation/screens/geolocation/bloc/geolocation_bloc.dart';
import 'package:chats/src/presentation/screens/geolocation/widgets/ui_events.dart';
import 'package:chats/src/presentation/shared/confirm_button.dart';
import 'package:chats/src/presentation/shared/cross_paint.dart';
import 'package:chats/src/presentation/shared/dialog.dart';
import 'package:chats/src/presentation/shared/header/header.dart';
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
part 'widgets/address.dart';
part 'widgets/interface_top.dart';
part 'widgets/result/dialog.dart';
part 'widgets/result/row.dart';

class PickGeolocationPage extends StatefulWidget {
  final Geolocation? initialGeolocation;

  const PickGeolocationPage({
    super.key,
    this.initialGeolocation,
  });

  @override
  State<PickGeolocationPage> createState() => _PickGeolocationPageState();
}

class _PickGeolocationPageState extends State<PickGeolocationPage> {
  final _mapUIEventsController = StreamController<MapUIEvent>();
  final _useCase = ReverseGeocodingUseCase(
    GeocoderRepositoryI(
      GeocoderDataSource(),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GeolocationBloc(_useCase),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            _MapWidget(
              initialGeolocation: widget.initialGeolocation,
              mapUIEventStream: _mapUIEventsController.stream,
            ),
            Center(
              child: _MapPointerWidget(),
            ),
            _MapInterfaceWidget(
              mapUIEventSink: _mapUIEventsController.sink,
            ),
          ],
        ),
      ),
    );
  }
}
