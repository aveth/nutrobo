import 'package:flutter/widgets.dart';
import 'package:nutrobo/chat_message.dart';

class ChatController extends ChangeNotifier {
  /* Variables */
  List<ChatMessage> chatList = List.generate(10, (index) => ChatMessage(
      message: "Hello $index",
      time: DateTime.now(),
      type: index % 2 == 0 ? ChatMessageType.received : ChatMessageType.sent
  ));

  /* Controllers */
  late final ScrollController scrollController = ScrollController();
  late final TextEditingController textEditingController = TextEditingController();
  late final FocusNode focusNode = FocusNode();

  /* Intents */
  Future<void> onFieldSubmitted() async {
    if (!isTextFieldEnable) return;

    chatList = [
      ...chatList,
      ChatMessage.sent(message: textEditingController.text),
    ];

    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    textEditingController.text = '';
    notifyListeners();
  }

  void onFieldChanged(String term) {
    notifyListeners();
  }

  /* Getters */
  bool get isTextFieldEnable => textEditingController.text.isNotEmpty;
}