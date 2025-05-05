import 'dart:async';

import 'package:core/src/map_config.dart';
import 'package:core/src/widgets/geolocation/bloc/geolocation_bloc.dart';
import 'package:core/src/widgets/geolocation/widgets/ui_events.dart';
import 'package:core/src/widgets/shared/confirm_button.dart';
import 'package:core/src/widgets/shared/cross_paint.dart';
import 'package:core/src/widgets/shared/dialog.dart';
import 'package:core/src/widgets/shared/header/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:ui_components/ui_components.dart';
import 'package:ui_utils/ui_utils.dart';

import '../../data/data_source/geocoder.dart';
import '../../data/repository/geocoder.dart';
import '../../domain/enitites/geolocation.dart';
import '../../domain/usecase/reverse_geocoding.dart';

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
