import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunwise_project/app/modules/chat_screen/controllers/chat_screen_controller.dart';
import 'package:sunwise_project/themes.dart';

class ChatBubble extends GetView<ChatScreenController> {
  final String message;
  final bool isUser;

  ChatBubble({required this.message, this.isUser = false});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: isUser ? double.infinity : 250,
        ),
        child: IntrinsicWidth(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 4.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: isUser ? accentColor : bubbleBot,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(message, style: regulerText17),
          ),
        ),
      ),
    );
  }
}
