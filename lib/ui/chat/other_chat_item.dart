import 'package:chat_app/model/chat.dart';
import 'package:flutter/material.dart';

class OtherChatItem extends StatelessWidget {
  final Chat chat;

  const OtherChatItem({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('남의 것'),
    );
  }
}
