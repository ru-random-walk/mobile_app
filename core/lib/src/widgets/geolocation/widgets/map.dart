part of '../page.dart';

const _apiKey = String.fromEnvironment('MAP_TILER_API_KEY');

class _MapWidget extends StatefulWidget {
  final Stream<MapUIEvent> mapUIEventStream;
  final Geolocation? initialGeolocation;

  const _MapWidget({
    super.key,
    required this.mapUIEventStream,
    this.initialGeolocation,
  });

  @override
  State<_MapWidget> createState() => __MapWidgetState();
}

class __MapWidgetState extends State<_MapWidget> {
  MapLibreMapController? _mapController;
  late final StreamSubscription<MapUIEvent> _mapUIEventsSubscription;
  final String _styleUrl =
      'https://api.maptiler.com/maps/basic-v2/style.json?key=$_apiKey';

  bool _locationPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    _mapUIEventsSubscription = widget.mapUIEventStream.listen((event) {
      switch (event) {
        case ZoomInEvent():
          zoomIn();
        case ZoomOutEvent():
          zoomOut();
        case ZoomToCurrentPositionEvent _:
          _zoomToUserCurrentPosition();
      }
    });
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

  Future<void> _initLocationLayer() async {
    _getCurrentPosition();
    if (widget.initialGeolocation != null) {
      await _moveCameraTo(widget.initialGeolocation!.point);
    } else {
      await _zoomToUserCurrentPosition();
    }
  }

  Future<void> _zoomToUserCurrentPosition() async {
    final userPosition = await _getCurrentPosition();
    if (userPosition != null) {
      await _moveCameraTo(
        LatLng(
          userPosition.latitude,
          userPosition.longitude,
        ),
      );
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Нет доступа к местоположению пользователя'),
          ),
        );
      });
    }
  }

  Future<void> _moveCameraTo(LatLng target, {double zoom = 17}) async {
    await _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: zoom),
      ),
    );
  }

  Future<void> zoomIn() async {
    await _mapController?.animateCamera(CameraUpdate.zoomIn());
  }

  Future<void> zoomOut() async {
    await _mapController?.animateCamera(CameraUpdate.zoomOut());
  }

  @override
  Widget build(BuildContext context) {
    final initialTarget = widget.initialGeolocation?.point ??
        const LatLng(55.751244, 37.618423); // fallback to Moscow

    return MapLibreMap(
      styleString: _styleUrl,
      initialCameraPosition: CameraPosition(
        target: initialTarget,
        zoom: 14,
      ),
      onMapCreated: (controller) async {
        _mapController = controller;
        _initLocationLayer();
      },
      onCameraIdle: () async {
        final cameraPosition = _mapController?.cameraPosition;
        final center = cameraPosition?.target;
        final zoom = cameraPosition?.zoom;
        if (center != null && zoom != null && context.mounted) {
          BlocProvider.of<GeolocationBloc>(context).add(
            GetLocationNameByPoint(
              point: center,
              zoom: zoom.toInt(),
            ),
          );
        }
      },
      trackCameraPosition: true,
      compassEnabled: false,
      myLocationEnabled: _locationPermissionGranted,
    );
  }

  @override
  void dispose() {
    _mapUIEventsSubscription.cancel();
    super.dispose();
  }
}
