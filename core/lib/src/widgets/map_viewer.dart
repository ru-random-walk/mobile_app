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
  late final YandexMapController _mapController;
  static const _mapAnimation = MapAnimation(
    type: MapAnimationType.linear,
    duration: 0.3,
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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final position = CameraPosition(target: widget.geolocation.point);
        _moveCameraTo(position);
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
      mapObjects: [
        PlacemarkMapObject(
          opacity: 1,
          mapId: const MapObjectId('geolocation'),
          icon: PlacemarkIcon.single(
            PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage(
                'packages/core/assets/place_fill.png',
              ),
              rotationType: RotationType.rotate,
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
