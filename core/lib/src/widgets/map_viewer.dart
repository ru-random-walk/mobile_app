import 'package:core/src/domain/enitites/geolocation.dart';
import 'package:core/src/map_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:geolocator/geolocator.dart';

class MapViewer extends StatefulWidget {
  final Geolocation geolocation;

  const MapViewer({
    super.key,
    required this.geolocation,
  });

  @override
  State<MapViewer> createState() => _MapViewerState();
}

class _MapViewerState extends State<MapViewer> {
  MapLibreMapController? _mapController;
  bool _locationPermissionGranted = false;

  Future<Position?> _getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }
    setState(() {
      _locationPermissionGranted = true;
    });
    return await Geolocator.getCurrentPosition();
  }

  Future<void> _initLocationLayer() => _getCurrentPosition();

  @override
  Widget build(BuildContext context) {
    return MapLibreMap(
      key: ObjectKey(widget.geolocation),
      styleString: mapUrl,
      initialCameraPosition: CameraPosition(
        target: widget.geolocation.point,
        zoom: 14,
      ),
      onMapCreated: (controller) async {
        _mapController = controller;
      },
      onStyleLoadedCallback: () async {
        _initLocationLayer();
        await _addMarker(widget.geolocation.point);
      },
      myLocationEnabled: _locationPermissionGranted,
      rotateGesturesEnabled: true,
      compassEnabled: false,
    );
  }

  Future<void> _addMarker(LatLng point) async {
    final bytes = await rootBundle.load('packages/core/assets/place_fill.png');
    final list = bytes.buffer.asUint8List();
    await _mapController?.addImage('pointer', list);
    _mapController?.addSymbol(
      SymbolOptions(
        geometry: point,
        iconImage: 'pointer',
      ),
    );
  }
}
