import 'package:chat_app/model/chat.dart';
import 'package:chat_app/ui/chat/my_chat_item.dart';
import 'package:chat_app/ui/chat/other_chat_item.dart';
import 'package:chat_app/viewmodel/chat_view_model.dart';
import 'package:chat_app/viewmodel/login_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatViewModel = context.watch<ChatViewModel>();
    final loginViewModel = context.watch<LoginViewModel>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '생존코딩 단체방',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<LoginViewModel>().logout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot<Chat>>(
                  stream: chatViewModel.getChatListStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }

                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final data = snapshot.requireData;

                    return ListView.builder(
                      reverse: true,
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        Chat chat = data.docs[index].data();
                        if (loginViewModel.user!.email == chat.email) {
                          return MyChatItem(chat: chat);
                        } else {
                          return OtherChatItem(chat: chat);
                        }
                      },
                    );
                  }),
            ),
            Column(
              children: [
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Message를 입력하세요',
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: null,
                      icon: Icon(Icons.email),
                    ),
                    IconButton(
                      onPressed: null,
                      icon: Icon(Icons.email),
                    ),
                    IconButton(
                      onPressed: null,
                      icon: Icon(Icons.email),
                    ),
                    IconButton(
                      onPressed: null,
                      icon: Icon(Icons.email),
                    ),
                    IconButton(
                      onPressed: null,
                      icon: Icon(Icons.email),
                    ),
                    Flexible(child: Container()),
                    TextButton(
                      onPressed: () async {
                        await chatViewModel.pushMessage(
                            _controller.text, loginViewModel.user!);

                        // 입력 창 초기화
                        _controller.clear();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        child: Text(
                          'SEND',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
