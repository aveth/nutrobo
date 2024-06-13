import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrobo/features/chat/bloc/chat_bloc.dart';
import 'package:nutrobo/features/chat/ui/chat_bubble.dart';

import 'chat_controller.dart';

class ChatMessages extends StatelessWidget {

  ChatMessages({super.key});

  late final ChatController _controller = ChatController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      bloc: context.watch<ChatBloc>(),
      builder: (context, state) {
        return _bodyFromState(state);
      }
    );
  }

  Widget _bodyFromState(ChatState state) {
    switch (state) {
      case InitialState():
        return const Center(
            child: CircularProgressIndicator()
        );
      case SuccessState():
        return ListView.separated(
          shrinkWrap: true,
          reverse: true,
          padding: const EdgeInsets.only(top: 12, bottom: 20) +
              const EdgeInsets.symmetric(horizontal: 12),
          separatorBuilder: (_, __) =>
          const SizedBox(
            height: 12,
          ),
          controller: _controller.scrollController,
          itemCount: state.messages.length,
          itemBuilder: (context, index) {
            return ChatBubble(message: state.messages[index]);
          },
        );
      default:
        return Container(color: Colors.white);
    }
  }
}

