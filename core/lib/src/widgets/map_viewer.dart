import 'package:core/src/domain/enitites/geolocation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

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
  late YandexMapController _mapController;
  static const _mapAnimation = MapAnimation(
    type: MapAnimationType.smooth,
    duration: 0.0,
  );

  Future<void> _moveCameraTo(CameraPosition cameraPosition) =>
      _mapController.moveCamera(
        CameraUpdate.newCameraPosition(
          cameraPosition.copyWith(zoom: 15),
        ),
        animation: _mapAnimation,
      );

  /// Метод, который включает слой местоположения пользователя на карте
  /// Выполняется проверка на доступ к местоположению, в случае отсутствия
  /// разрешения - выводит сообщение
  Future<void> _initLocationLayer() async {
    final locationPermissionIsGranted =
        await Permission.location.request().isGranted;

    if (locationPermissionIsGranted) {
      await _mapController.toggleUserLayer(visible: true);
      final position = CameraPosition(target: widget.geolocation.point);
      _moveCameraTo(position);
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
      key: ObjectKey(widget.geolocation),
      mapObjects: [
        PlacemarkMapObject(
          opacity: 1,
          mapId: const MapObjectId('geolocation'),
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              anchor: const Offset(0.5, 1),
              image: BitmapDescriptor.fromAssetImage(
                'packages/core/assets/place_fill.png',
              ),
              rotationType: RotationType.noRotation,
            ),
          ),
          point: widget.geolocation.point,
        ),
      ],
      onMapCreated: (controller) async {
        _mapController = controller;
        _initLocationLayer();
      },
    );
  }
}
