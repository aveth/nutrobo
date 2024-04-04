import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nutrobo/extensions/flutter_secure_storage.dart';
import 'package:nutrobo/features/chat/model/chat_message.dart';
import 'package:nutrobo/features/chat/model/message.dart';
import 'package:nutrobo/features/chat/model/send_message.dart';
import 'package:nutrobo/features/chat/model/thread.dart';
import 'package:nutrobo/features/chat/service/nutrobo_api.dart';

abstract class ChatEvent { }
abstract class ChatState { }

class InitialEvent extends ChatEvent { }

class SendEvent extends ChatEvent {
  final String message;
  SendEvent({required this.message});
}
class ReceiveEvent extends ChatEvent { }

class InitialState extends ChatState { }

class SuccessState extends ChatState {
  final List<ChatMessage> messages;
  SuccessState({required this.messages});
}

class ChatBloc extends Bloc<ChatEvent, ChatState> {

  final FlutterSecureStorage storage;
  final NutroboApi api;

  List<Message> _currentMessages = [];

  ChatBloc({
    required this.storage,
    required this.api
  }) : super(InitialState()) {

    on<InitialEvent>((event, emit) async {
      var threadId = await storage.getThreadId();
      Response<Thread> response;
      if (threadId == null) {
        response = await api.createThread();
        var id = response.body?.id;
        if (id == null) {
          emit(_stateFromResponse(null));
        } else {
          storage.setThreadId(id);
        }
      } else {
        response = await api.getThread(threadId);
      }

      emit(_stateFromResponse(response));
    });

    on<SendEvent>((event, emit) async {
      var threadId = await storage.getThreadId() ?? "";
      final response = await api.sendMessage(SendMessage(
          threadId: threadId,
          content: event.message,
          data: [
            "You can calculate the user's insulin dose by using the insulin-to-carbohydrate ratio of 1:10",
            'The user should be address as Avais'
          ]
      ));

      emit(_stateFromResponse(response));
    });

    add(InitialEvent());
  }

  void sendMessage(String message) {
    add(SendEvent(message: message));
  }

  ChatState _stateFromResponse(Response<Thread>? response) {
    if (response != null && response.isSuccessful) {
      var messages = response.body?.messages;
      if (messages != null) {
        _currentMessages = messages;
      }
    }

    return SuccessState(messages: _currentMessages.map((m) =>
        ChatMessage.fromMessage(m)
    ).toList());
  }

}
