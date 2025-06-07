part of '../page.dart';

class _MapPreview extends StatelessWidget {
  final Geolocation geolocation;

  const _MapPreview({required this.geolocation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapViewer(geolocation: geolocation),
          Positioned(
            left: 16.toFigmaSize,
            right: 16.toFigmaSize,
            bottom: 40.toFigmaSize,
            child: SafeArea(
              child: CustomButton(
                text: 'Проложить маршрут',
                onPressed: () async {
                  if (kIsWeb) {
                    final lat = geolocation.point.latitude.toString();
                    final lon = geolocation.point.longitude.toString();
                    final appleMapsUri = Uri.parse(
                      'https://maps.apple.com/?daddr=$lat,$lon&dirflg=d',
                    );
                    launchUrl(appleMapsUri);
                  } else {
                    final availableMaps = await MapLauncher.installedMaps;
                    if (availableMaps.isNotEmpty) {
                      await availableMaps.first.showDirections(
                        destination: Coords(
                          geolocation.point.latitude,
                          geolocation.point.longitude,
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ),
          Visibility(
            visible: geolocation.hasDisplayName,
            child: Positioned(
              left: 20.toFigmaSize,
              right: 20.toFigmaSize,
              top: 20.toFigmaSize,
              child: SafeArea(
                child: Text(
                  geolocation.toString(),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.h5,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
