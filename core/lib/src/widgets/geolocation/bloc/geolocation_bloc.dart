import 'package:bloc/bloc.dart';
import 'package:core/src/widgets/geolocation/bloc/debouncer.dart';
import 'package:meta/meta.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../../domain/enitites/geolocation.dart';
import '../../../domain/usecase/reverse_geocoding.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

const _debounceDuration = Duration(milliseconds: 300);

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  final ReverseGeocodingUseCase _geocodingUseCase;

  GeolocationBloc(this._geocodingUseCase) : super(GeolocationLoading()) {
    on<GetLocationNameByPoint>(
      _onNewPointFromMap,
      transformer: debounced(duration: _debounceDuration),
    );
  }

  void _onNewPointFromMap(
    GetLocationNameByPoint event,
    Emitter<GeolocationState> emit,
  ) async {
    emit(GeolocationLoading());
    final res = await _geocodingUseCase(event.point);
    res.fold(
      (_) => emit(GeolocationFailure()),
      (geo) => emit(
        GeolocationData(geolocation: geo),
      ),
    );
  }
}
