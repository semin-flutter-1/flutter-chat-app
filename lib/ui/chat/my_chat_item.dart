import 'package:chat_app/model/chat.dart';
import 'package:chat_app/util/date_util.dart';
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
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
                bottomLeft: Radius.circular(24),
              ),
              color: Colors.blueAccent[700],
            ),
            padding: const EdgeInsets.all(8),
            child: Text(
              chat.message!,
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 4),
          Text(
            chat.time!.toDateString(),
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
