import 'package:auth/auth.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:chats/src/presentation/screens/chat_list/bloc/chats_list_bloc.dart';
import 'package:core/core.dart';
import 'package:mocktail/mocktail.dart';
import 'package:utils/utils.dart';

import 'generate_chats.dart';

class MockChatsListBloc extends MockBloc<ChatsListEvent, ChatsListState>
    implements ChatsListBloc {}

class MockTokenStorage extends Mock implements TokenStorage {}

class MockGetProfileUseCase extends Mock implements GetProfileUseCase {}

ChatsListBloc mockBlocWithState(ChatsListState state) {
  final bloc = MockChatsListBloc();
  when(() => bloc.state).thenReturn(state);
  whenListen(
    bloc,
    Stream<ChatsListState>.fromIterable([state]),
  );
  return bloc;
}

MockGetProfileUseCase getMockGetProfileUseCase(){
  final mock = MockGetProfileUseCase();
  when(() => mock.call(any()))
      .thenAnswer((_) async => 
        Right<BaseError, DetailedUserEntity>(detailedUser),);
  return mock; 
}
