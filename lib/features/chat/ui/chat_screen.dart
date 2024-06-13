import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:nutrobo/core/command.dart';
import 'package:nutrobo/features/barcode/bloc/barcode_bloc.dart';
import 'package:nutrobo/features/barcode/ui/barcode_scanner.dart';
import 'package:nutrobo/features/chat/bloc/chat_bloc.dart';
import 'package:nutrobo/features/chat/ui/chat_messages.dart';
import 'package:nutrobo/features/chat/ui/command_bubble.dart';
import 'package:nutrobo/features/chat/ui/input_field.dart';
import 'package:nutrobo/features/ocr/ui/ocr_scanner.dart';

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
              child: BlocBuilder<BarcodeBloc, BarcodeState>(
                  bloc: context.watch<BarcodeBloc>(),
                  builder: (context, state) {
                    switch (state) {
                      case BarcodeFoundState _:
                        context.read<ChatBloc>().sendBarcode(state.barcode);
                        break;
                      case NutritionInfoFoundState _:
                        context.read<ChatBloc>().sendNutritionInfo(state.info);
                        break;
                      case NotFoundState _:
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Unable to find information for barcode.")));
                        break;
                    }
                    return ChatMessages();
                  })),
        )),
        Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(spacing: 10, children: [
                  _barcodeBubble(context, context.read<BarcodeBloc>()),
                  _ocrBubble(context, context.read<BarcodeBloc>())
                ]))),
        InputField(controller: _controller),
      ],
    );
  }
}

CommandBubble _barcodeBubble(BuildContext context, BarcodeBloc bloc) =>
    CommandBubble(
        command: Command.barcodeScanner(context),
        onPressed: () async {
          var result = await Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (context) => const BarcodeScanner()));
          if (result != null && result is BarcodeCapture) {
            bloc.barcodeFound(result);
          }
        });

CommandBubble _ocrBubble(BuildContext context, BarcodeBloc bloc) =>
    CommandBubble(
        command: Command.ocrScanner(context),
        onPressed: () async {
          var result = await Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(builder: (context) => const OcrScanner()));
          if (result != null && result is String) {
            bloc.nutritionInfoFound(result);
          }
        });
