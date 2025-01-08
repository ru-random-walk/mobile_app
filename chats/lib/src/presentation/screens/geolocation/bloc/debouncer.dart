import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

EventTransformer<T> debounced<T>({required Duration duration}) {
  return (events, mapper) =>  events
      .debounceTime(duration)
      .asyncExpand(mapper);
}