import 'dart:async';

typedef Callback = void Function();

class Debouncer {
  final Duration _duration;
  Timer? _timer;

  Debouncer([this._duration = const Duration(milliseconds: 500)]);

  void debounce(Callback callback) {
    _timer?.cancel();
    _timer = Timer(_duration, callback);
  }

  void cancel() => _timer?.cancel();
}