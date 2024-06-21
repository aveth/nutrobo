import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:nutrobo/features/auth/service/auth_service.dart';
import 'package:nutrobo/features/chat/model/chat_message.dart';
import 'package:nutrobo/features/chat/model/send_message.dart';
import 'package:nutrobo/features/chat/model/thread.dart';
import 'package:nutrobo/features/chat/service/nutrobo_api.dart';
import 'package:nutrobo/features/meals/model/food.dart';

abstract class ChatEvent {}

abstract class ChatState {}

class InitialEvent extends ChatEvent {}

class SendEvent extends ChatEvent {
  final String message;

  SendEvent({required this.message});
}

class BarcodeEvent extends ChatEvent {
  final String barcode;

  BarcodeEvent({required this.barcode});
}

class NutritionInfoEvent extends ChatEvent {
  final Food food;

  NutritionInfoEvent({required this.food});
}

class InitialState extends ChatState {}

class SuccessState extends ChatState {
  final List<ChatMessage> messages;

  SuccessState({required this.messages});
}

class LoadingState extends SuccessState {
  LoadingState({required super.messages});
}

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final AuthService auth;
  final NutroboApi api;

  static const _loadingValue = '...';

  List<ChatMessage> _currentMessages = [];

  ChatBloc({required this.auth, required this.api}) : super(InitialState()) {
    on<InitialEvent>((event, emit) async {
      var threadId = (await api.getProfile()).body?.threads.firstOrNull;
      Response<Thread> response;
      if (threadId == null) {
        response = await api.createThread();
        var id = response.body?.id;
        if (id == null) {
          emit(_stateFromResponse(null));
        }
      } else {
        response = await api.getThread(threadId);
      }

      emit(_stateFromResponse(response));
    });

    on<SendEvent>((event, emit) async {
      var messages = _currentMessages;
      messages.insert(
          0,
          ChatMessage(
              message: event.message,
              time: DateTime.now(),
              type: ChatMessageType.sent));

      messages.insert(
          0,
          ChatMessage(
              message: _loadingValue,
              time: DateTime.now(),
              type: ChatMessageType.received));

      emit(_stateFromMessages(messages));

      final threadId = (await api.getProfile()).body?.threads.firstOrNull;
      if (threadId == null) return;

      final response = await api.sendMessage(
          threadId,
          SendMessage(content: event.message, data: [
            "You can calculate the user's insulin dose by using the insulin-to-carbohydrate ratio of 1:10",
            'The user should be addressed as Avais'
          ]));

      emit(_stateFromResponse(response));

    });

    on<NutritionInfoEvent>((event, emit) async {
      final threadId = (await api.getProfile()).body?.threads.firstOrNull;
      if (threadId == null) return;

      final response = await api.sendNutritionInfo(
        threadId,
        event.food,
      );

      emit(_stateFromResponse(response));
    });

    add(InitialEvent());
  }

  void sendMessage(String message) {
    add(SendEvent(message: message));
  }

  void sendBarcode(String barcode) {
    add(BarcodeEvent(barcode: barcode));
  }

  void sendNutritionInfo(Food food) {
    add(NutritionInfoEvent(food: food));
  }

  ChatState _stateFromResponse(Response<Thread>? response) {
    if (response != null && response.isSuccessful) {
      var messages = response.body?.messages;
      if (messages != null) {
        _currentMessages =
            messages.map((m) => ChatMessage.fromMessage(m)).toList();
      }
    }

    return _stateFromMessages(_currentMessages);
  }

  ChatState _stateFromMessages(List<ChatMessage> messages) {
    if (messages.firstOrNull?.message == _loadingValue) {
      return LoadingState(messages: messages);
    } else {
      return SuccessState(messages: messages);
    }
  }
}
