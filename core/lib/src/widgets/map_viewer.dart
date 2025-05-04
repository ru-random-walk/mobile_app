import 'package:core/src/domain/enitites/geolocation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
import 'package:geolocator/geolocator.dart';

const _apiKey = String.fromEnvironment('MAP_TILER_API_KEY');

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

  final String _styleUrl =
      'https://api.maptiler.com/maps/basic-v2/style.json?key=$_apiKey';

  bool _locationPermissionGranted = false;

  Future<void> _moveCameraTo(LatLng point, {double zoom = 15}) async {
    await _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: point, zoom: zoom),
      ),
    );
  }

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
      styleString: _styleUrl,
      initialCameraPosition: CameraPosition(
        target: widget.geolocation.point,
        zoom: 14,
      ),
      onMapCreated: (controller) async {
        _mapController = controller;
      },
      onStyleLoadedCallback: () async {
        await _initLocationLayer();
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
        iconImage: 'pointer', // Default Mapbox-style icon
      ),
    );
  }
}
