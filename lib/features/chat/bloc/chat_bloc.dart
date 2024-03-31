import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nutrobo/features/chat/bloc/gpt_sdk.dart';
import 'package:nutrobo/features/chat/ui/chat_message.dart';

abstract class ChatEvent { }

class SendEvent extends ChatEvent {
  final String message;
  SendEvent({required this.message});
}
class ReceiveEvent extends ChatEvent { }

class ChatState {
  final List<ChatMessage> messages;

  ChatState({required this.messages});
}

class ChatBloc extends Bloc<ChatEvent, ChatState> {

  final GptSdk gptSdk = GetIt.instance.get<GptSdk>();

  ChatBloc() : super(ChatState(messages: [])) {
    on<SendEvent>((event, emit) async {
      //await gptSdk.sendMessage(event.message);
      var current = state.messages
          ..add(ChatMessage.sent(message: event.message));
      emit(ChatState(messages: current));
    });
  }

  void sendMessage(String message) {
    add(SendEvent(message: message));
  }

}
