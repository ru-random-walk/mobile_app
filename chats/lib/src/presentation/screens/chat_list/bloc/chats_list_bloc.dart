import 'package:bloc/bloc.dart';
import 'package:chats/src/domain/entity/chat/chat.dart';
import 'package:chats/src/domain/use_case/get_chats.dart';
import 'package:core/core.dart';
import 'package:meta/meta.dart';

part 'chats_list_event.dart';
part 'chats_list_state.dart';

class ChatsListBloc extends Bloc<ChatsListEvent, ChatsListState> {
  final GetChatsUseCase _getChatsUseCase;

  ChatsListBloc(this._getChatsUseCase) : super(ChatsListLoading()) {
    on<GetChatsEvent>(_onGetChats);
  }

  void _onGetChats(GetChatsEvent event, Emitter emit) async {
    emit(ChatsListLoading());
    final res = await _getChatsUseCase();
    res.fold((e) {
      emit(ChatsListError(error: e));
    }, (data) {
      emit(ChatsListData(chats: data));
    });
  }
}
