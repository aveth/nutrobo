import 'package:flutter/material.dart';
import 'package:nutrobo/core/command.dart';

class CommandBubble extends StatelessWidget {

  final Command command;
  final Function onPressed;

  const CommandBubble({
    super.key,
    required this.onPressed,
    required this.command,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.zero,
        child: ElevatedButton.icon(
            onPressed: () => onPressed(),
            onLongPress: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(command.description))
            ),
            icon: Icon(command.icon),
            label: Text(command.title)
        )
    );
  }


}