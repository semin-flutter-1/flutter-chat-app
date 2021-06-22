import 'package:chat_app/model/chat.dart';
import 'package:chat_app/repository/fake_repository.dart';
import 'package:chat_app/repository/firebase_repository.dart';
import 'package:chat_app/repository/repository.dart';
import 'package:chat_app/ui/chat/my_chat_item.dart';
import 'package:chat_app/ui/chat/other_chat_item.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {

  ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final myEmail = 'bbb@aaa.com';

  final Repository repository = FakeRepository();

  @override
  void initState() {
    super.initState();
  }

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
              child: FutureBuilder<List<Chat>>(
                future: repository.getChatList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData) {
                    return Center(child: Text('데이터 없음'));
                  }

                  List<Chat> items = snapshot.data!;

                  return ListView.builder(
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
                  );
                }
              ),
            ),
            TextField(),
          ],
        ),
      ),
    );
  }
}
