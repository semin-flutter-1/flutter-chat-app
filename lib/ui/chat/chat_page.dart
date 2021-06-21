import 'package:chat_app/model/chat.dart';
import 'package:chat_app/ui/chat/my_chat_item.dart';
import 'package:chat_app/ui/chat/other_chat_item.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final myEmail = 'bbb@aaa.com';

  final items = [
    Chat('홍길동', null, 'hello world', 100234234234, 'aaa@aaa.com'),
    Chat('홍길동', null, 'hello world 2', 100234234234, 'aaa@aaa.com'),
    Chat('한석봉', null, 'hello world 3', 100234234234, 'bbb@aaa.com'),
  ];

  ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  Chat chat = items[index];
                  if (myEmail == chat.email) {
                    return MyChatItem(chat: chat);
                  } else {
                    return OtherChatItem(chat: chat);
                  }
                },
              ),
            ),
            TextField(),
          ],
        ),
      ),
    );
  }
}
