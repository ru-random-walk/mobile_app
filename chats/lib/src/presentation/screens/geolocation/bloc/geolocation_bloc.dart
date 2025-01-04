import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:meta/meta.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  GeolocationBloc() : super(GeolocationLoading()) {
    on<GetLocationNameByPoint>(
      (event, emit) async {
        final res = await _fetchLocationNameByPoint(event);
        emit(GeolocationData(name: res));
      },
      transformer: restartable(),
    );
  }

  Future<String> _fetchLocationNameByPoint(GetLocationNameByPoint event) async {
    final res = await YandexSearch.searchByPoint(
      point: event.point,
      zoom: event.zoom,
      searchOptions: const SearchOptions(),
    );
    final place = await res.$2;
    final places = place.items;
    if (places != null && places.isNotEmpty) {
      final placeName = places.first.name;
      print(placeName);
      return placeName;
    }
    return 'Неизвестно';
  }
}
