part of '../page.dart';

class _MapInterfaceWidget extends StatefulWidget {
  final StreamSink<MapUIEvent> mapUIEventSink;

  const _MapInterfaceWidget({
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
        padding: EdgeInsets.fromLTRB(
          16.toFigmaSize,
          16.toFigmaSize,
          16.toFigmaSize,
          0,
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
              onTap: () async {
                final currentPickedGeolocation =
                    context.read<GeolocationBloc>().state;
                if (currentPickedGeolocation is GeolocationData) {
                  final res = await showDialog(
                    context: context,
                    builder: (_) => _ApplyLocationResultDialog(),
                    routeSettings: RouteSettings(
                      arguments: currentPickedGeolocation.geolocation,
                    ),
                  );
                  if (!context.mounted) return;
                  if (res is Geolocation) {
                    Navigator.pop(context, res);
                  }
                }
              },
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.toFigmaSize),
                child: SizedBox(
                  height: 40.toFigmaSize,
                  width: 100.toFigmaSize,
                  child: Image.asset(
                    'packages/core/assets/map_tiler_logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
