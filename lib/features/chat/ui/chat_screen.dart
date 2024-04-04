import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrobo/features/chat/bloc/chat_bloc.dart';
import 'package:nutrobo/features/chat/ui/chat_bubble.dart';

import 'chat_controller.dart';

class ChatScreen extends StatelessWidget {

  ChatScreen({super.key});

  late final ChatController _controller = ChatController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Nutrobo: Your AI Nutrition Assistant"),
        backgroundColor: const Color(0xFF007AFF),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                _controller.focusNode.unfocus();
                // FocusScope.of(context).unfocus();
              },
              child: Align(
                alignment: Alignment.topCenter,
                child: BlocBuilder<ChatBloc, ChatState>(
                  bloc: context.watch<ChatBloc>(),
                  builder: (context, chatState) {
                    switch (chatState.runtimeType) {
                      case InitialState:
                        return const CircularProgressIndicator();
                      case SuccessState:
                        chatState as SuccessState;
                        return ListView.separated(
                          shrinkWrap: true,
                          reverse: true,
                          padding: const EdgeInsets.only(top: 12, bottom: 20) +
                              const EdgeInsets.symmetric(horizontal: 12),
                          separatorBuilder: (_, __) => const SizedBox(
                            height: 12,
                          ),
                          controller: _controller.scrollController,
                          itemCount: chatState.messages.length,
                          itemBuilder: (context, index) {
                            return ChatBubble(message: chatState.messages[index]);
                          },
                        );
                      default:
                        return Container();
                    }

                  },
                ),
              ),
            ),
          ),
          _BottomInputField(controller: _controller),
        ],
      ),
    );
  }
}

/// Bottom Fixed Filed
class _BottomInputField extends StatelessWidget {

  final ChatController controller;

  const _BottomInputField({
    required this.controller, super.key
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Container(
        constraints: const BoxConstraints(minHeight: 48),
        width: double.infinity,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xFFE5E5EA),
            ),
          ),
        ),
        child: Stack(
          children: [
            TextField(
              focusNode: controller.focusNode,
              onChanged: controller.onFieldChanged,
              controller: controller.textEditingController,
              maxLines: null,
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.only(
                  right: 42,
                  left: 16,
                  top: 18,
                ),
                hintText: 'message',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            // custom suffix btn
            Positioned(
              bottom: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  var text = controller.onFieldSubmitted();
                  context.read<ChatBloc>().sendMessage(text);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

