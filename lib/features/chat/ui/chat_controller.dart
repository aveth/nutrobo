import 'package:flutter/widgets.dart';

class ChatController {

  /* Controllers */
  final ScrollController scrollController = ScrollController();
  final TextEditingController textEditingController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  /* Intents */
  String onFieldSubmitted() {
    if (!isTextFieldEnable) return "";

    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    var text = textEditingController.text;
    textEditingController.text = '';

    return text;
  }

  void onFieldChanged(String term) {

  }

  /* Getters */
  bool get isTextFieldEnable => textEditingController.text.isNotEmpty;
}