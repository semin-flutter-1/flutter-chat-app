import 'package:chat_app/model/chat.dart';
import 'package:flutter/material.dart';

class MyChatItem extends StatelessWidget {
  final Chat chat;

  const MyChatItem({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('내 것'),
    );
  }
}
