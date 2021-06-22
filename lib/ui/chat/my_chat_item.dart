import 'package:chat_app/model/chat.dart';
import 'package:chat_app/ui/chat/other_chat_item.dart';
import 'package:flutter/material.dart';

class MyChatItem extends StatelessWidget {
  final Chat chat;

  const MyChatItem({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(timeNow()),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.yellow[200],
            ),
            padding: const EdgeInsets.all(8),
            child: Text(chat.message),
          ),
        ],
      ),
    );
  }
}
