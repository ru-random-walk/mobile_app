part of '../page.dart';

class _MapInterfaceWidget extends StatefulWidget {
  final StreamSink<MapUIEvent> mapUIEventSink;

  const _MapInterfaceWidget({
    super.key,
    required this.mapUIEventSink,
  });

  @override
  State<_MapInterfaceWidget> createState() => _MapInterfaceWidgetState();
}

class _MapInterfaceWidgetState extends State<_MapInterfaceWidget> {
  void onZoomIn() => widget.mapUIEventSink.add(ZoomInEvent());

  void onZoomOut() => widget.mapUIEventSink.add(ZoomOutEvent());

  void onZoomToCurrentLocation() =>
      widget.mapUIEventSink.add(ZoomToCurrentPositionEvent());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(
          16.toFigmaSize,
        ),
        child: Column(
          children: [
            const Expanded(
              child: _MapInterfaceTopWidget(),
            ),
            Expanded(
              child: _ZoomMapButtons(
                onZoomIn: onZoomIn,
                onZoomOut: onZoomOut,
              ),
            ),
            Expanded(
              child: _ZoomToCurrentLocationButton(
                onPressed: onZoomToCurrentLocation,
              ),
            ),
            PickerConfirmButton(
              onTap: () {
                final currentPickedGeolocation =
                    context.read<GeolocationBloc>().state;
                if (currentPickedGeolocation is GeolocationData) {
                  showDialog(
                    context: context,
                    builder: (_) => _ApplyLocationResultDialog(),
                    routeSettings: RouteSettings(
                      arguments: currentPickedGeolocation.geolocation,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
