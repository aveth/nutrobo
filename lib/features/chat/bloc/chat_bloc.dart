import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nutrobo/extensions/flutter_secure_storage.dart';
import 'package:nutrobo/features/chat/model/chat_message.dart';
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

class ErrorState extends ChatState {
  final String message;
  ErrorState({required this.message});
}

class ChatBloc extends Bloc<ChatEvent, ChatState> {

  final FlutterSecureStorage storage;
  final NutroboApi api;

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
          emit(ErrorState(
              message: 'Unable to connect to Nutrobo.'
          ));
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
          content: event.message
      ));

      emit(_stateFromResponse(response));
    });

    add(InitialEvent());
  }

  void sendMessage(String message) {
    add(SendEvent(message: message));
  }

  ChatState _stateFromResponse(Response<Thread> response) {
    var thread = response.body;
    if (!response.isSuccessful || thread == null) {
      return ErrorState(
          message: 'HTTP error: ${response.statusCode}'
      );
    } else {
      return SuccessState(messages: thread.messages.map((e) =>
          ChatMessage.fromMessage(e)
      ).toList());
    }
  }

}
