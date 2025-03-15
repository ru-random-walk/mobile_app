part of '../page.dart';

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
  late final YandexMapController _mapController;
  CameraPosition? _userLocation;
  late final StreamSubscription<MapUIEvent> _mapUIEventsSubscription;
  static const _mapAnimation = MapAnimation(
    type: MapAnimationType.linear,
    duration: 0.3,
  );

  @override
  initState() {
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

  Future<void> _zoomToUserCurrentPosition() async {
    _userLocation = await _mapController.getUserCameraPosition();
    // если местоположение найдено, центрируем карту относительно этой точки
    if (_userLocation != null) {
      await _moveCameraTo(_userLocation!);
    }
  }

  Future<void> _moveCameraTo(CameraPosition cameraPosition) =>
      _mapController.moveCamera(
        CameraUpdate.newCameraPosition(
          cameraPosition.copyWith(zoom: 20),
        ),
        animation: _mapAnimation,
      );

  Future<void> zoomIn() async {
    await _mapController.moveCamera(
      CameraUpdate.zoomIn(),
      animation: _mapAnimation,
    );
  }

  Future<void> zoomOut() async {
    await _mapController.moveCamera(
      CameraUpdate.zoomOut(),
      animation: _mapAnimation,
    );
  }

  /// Метод, который включает слой местоположения пользователя на карте
  /// Выполняется проверка на доступ к местоположению, в случае отсутствия
  /// разрешения - выводит сообщение
  Future<void> _initLocationLayer() async {
    final locationPermissionIsGranted =
        await Permission.location.request().isGranted;

    if (locationPermissionIsGranted) {
      await _mapController.toggleUserLayer(visible: true);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.initialGeolocation != null) {
          final position =
              CameraPosition(target: widget.initialGeolocation!.point);
          _moveCameraTo(position);
        }
      });
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

  @override
  Widget build(BuildContext context) {
    return YandexMap(
      onMapCreated: (controller) async {
        _mapController = controller;
        _initLocationLayer();
      },
      onCameraPositionChanged: (cameraPosition, reason, finished) {
        final point = cameraPosition.target;
        final zoom = cameraPosition.zoom;
        BlocProvider.of<GeolocationBloc>(context).add(GetLocationNameByPoint(
          point: point,
          zoom: zoom.toInt(),
        ));
      },
      onUserLocationAdded: (view) async {
        if (widget.initialGeolocation == null) {
          // получаем местоположение пользователя
          _zoomToUserCurrentPosition();
        }
        // меняем внешний вид маркера - делаем его непрозрачным
        return view.copyWith(
          pin: view.pin.copyWith(
            opacity: 1,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _mapUIEventsSubscription.cancel();
    super.dispose();
  }
}
