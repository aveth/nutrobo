enum ChatMessageType {
  sent,
  received,
}

class ChatMessage {
  final String message;
  final ChatMessageType type;
  final DateTime time;

  ChatMessage({
    required this.message,
    required this.type,
    required this.time
  });

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