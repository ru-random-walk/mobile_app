import 'package:bloc/bloc.dart';
import 'package:chats/src/domain/entity/chat/chat.dart';
import 'package:chats/src/domain/entity/message/message.dart';
import 'package:chats/src/domain/use_case/get_chats.dart';
import 'package:core/core.dart';
import 'package:meta/meta.dart';

part 'chats_list_event.dart';
part 'chats_list_state.dart';

class ChatsListBloc extends Bloc<ChatsListEvent, ChatsListState> {
  final GetChatsUseCase _getChatsUseCase;

  ChatsListBloc(this._getChatsUseCase) : super(ChatsListLoading()) {
    on<GetChatsEvent>(_onGetChats);
    on<LastMessageChatUpdated>(_onLastMessageUpdated);
  }

  void _onGetChats(GetChatsEvent event, Emitter emit) async {
    if (event.resetPagination) _getChatsUseCase.reset();
    emit(ChatsListLoading());
    final res = await _getChatsUseCase();
    res.fold((e) {
      emit(ChatsListError(error: e));
    }, (data) {
      if (data.isEmpty) {
        emit(ChatsListEmpty());
      } else {
        emit(ChatsListData(chats: data));
      }
    });
  }

  void _onLastMessageUpdated(LastMessageChatUpdated event, Emitter emit) {
    final state = this.state;
    if (state is ChatsListData) {
      final chat = state.chats.firstWhere((e) => e.id == event.chatId);
      final message = event.message;
      final index = state.chats.indexOf(chat);
      final newChats = state.chats;
      newChats[index] = chat.copyWith(lastMessage: message);
      emit(ChatsListData(chats: [...newChats]));
    }
  }
}
