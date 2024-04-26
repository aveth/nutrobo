import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrobo/features/chat/bloc/chat_bloc.dart';

import 'chat_controller.dart';

class InputField extends StatelessWidget {

  final ChatController controller;

  const InputField({
    required this.controller,
    super.key
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
                  onPressed: context.read<ChatBloc>().state is LoadingState
                      ? null
                      : () => context.read<ChatBloc>().sendMessage(
                      controller.onFieldSubmitted()
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}