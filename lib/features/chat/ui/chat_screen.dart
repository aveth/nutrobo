import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrobo/core/command.dart';
import 'package:nutrobo/core/routes.dart';
import 'package:nutrobo/features/chat/bloc/chat_bloc.dart';
import 'package:nutrobo/features/chat/ui/chat_messages.dart';
import 'package:nutrobo/features/chat/ui/command_bubble.dart';
import 'package:nutrobo/features/chat/ui/input_field.dart';

import 'chat_controller.dart';

class ChatScreen extends StatelessWidget {

  ChatScreen({super.key});

  late final ChatController _controller = ChatController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GestureDetector(onTap: () {
            _controller.focusNode.unfocus();
          },
          child: Align(
              alignment: Alignment.topCenter,
              child: ChatMessages(),
        ))),
        Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(spacing: 10, children: [
                  _barcodeBubble(context, (result) =>
                      context.read<ChatBloc>().sendMessage(result)
                  ),
                  _ocrBubble(context)
                ]))),
        InputField(controller: _controller),
      ],
    );
  }
}

CommandBubble _barcodeBubble(BuildContext context, void Function(String) callback) =>
    CommandBubble(
        command: Command.barcodeScanner(context),
        onPressed: () async {
          var result = await Routes.toBarcodeScanner(context);
          if (result != null && result is String) {
            callback(result);
          }
        });

CommandBubble _ocrBubble(BuildContext context) =>
    CommandBubble(
        command: Command.ocrScanner(context),
        onPressed: () async {
          var result = await Routes.toOcrScanner(context);
          if (result != null && result is String) {
          }
        });
