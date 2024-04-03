import 'package:nutrobo/features/chat/model/message.dart';

enum ChatMessageType {
  sent,
  received,
}

class ChatMessage {
  final String? id;
  final String message;
  final ChatMessageType type;
  final DateTime time;

  ChatMessage({
    this.id,
    required this.message,
    required this.type,
    required this.time
  });

  factory ChatMessage.fromMessage(Message rawMessage) =>
    ChatMessage(
        id: rawMessage.id,
        message: rawMessage.content,
        type: rawMessage.sentBy == 'user' ? ChatMessageType.sent : ChatMessageType.received,
        time: rawMessage.createdAt
    );

  factory ChatMessage.sent({required message}) =>
      ChatMessage(
          message: message,
          type: ChatMessageType.sent,
          time: DateTime.now()
      );

  factory ChatMessage.received({required message}) =>
      ChatMessage(
          message: message,
          type: ChatMessageType.received,
          time: DateTime.now()
      );

}