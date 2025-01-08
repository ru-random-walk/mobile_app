import 'package:bloc/bloc.dart';
import 'package:chats/src/domain/entity/meet_data/geolocation.dart';
import 'package:chats/src/domain/use_case/reverse_geocoding.dart';
import 'package:chats/src/presentation/screens/geolocation/bloc/debouncer.dart';
import 'package:core/src/error/base.dart';
import 'package:meta/meta.dart';
import 'package:utils/utils.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

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
