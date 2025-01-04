part of '../page.dart';

class _MapWidget extends StatefulWidget {
  const _MapWidget({super.key});

  @override
  State<_MapWidget> createState() => __MapWidgetState();
}

class __MapWidgetState extends State<_MapWidget> {
  late final YandexMapController _mapController;
  CameraPosition? _userLocation;

  /// Метод, который включает слой местоположения пользователя на карте
  /// Выполняется проверка на доступ к местоположению, в случае отсутствия
  /// разрешения - выводит сообщение
  Future<void> _initLocationLayer() async {
    final locationPermissionIsGranted =
        await Permission.location.request().isGranted;

    if (locationPermissionIsGranted) {
      await _mapController.toggleUserLayer(visible: true);
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
        // получаем местоположение пользователя
        _userLocation = await _mapController.getUserCameraPosition();
        // если местоположение найдено, центрируем карту относительно этой точки
        if (_userLocation != null) {
          await _mapController.moveCamera(
            CameraUpdate.newCameraPosition(
              _userLocation!.copyWith(zoom: 10),
            ),
            animation: const MapAnimation(
              type: MapAnimationType.linear,
              duration: 0.3,
            ),
          );

          final res = await YandexSearch.searchByPoint(
              point: _userLocation!.target,
              searchOptions: const SearchOptions());
          final place = await res.$2;
          print(place.items?.first.name);
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
}
