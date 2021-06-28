import 'package:chat_app/model/chat.dart';
import 'package:chat_app/ui/chat/my_chat_item.dart';
import 'package:chat_app/ui/chat/other_chat_item.dart';
import 'package:chat_app/viewmodel/chat_view_model.dart';
import 'package:chat_app/viewmodel/login_view_model.dart';
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
  void initState() {
    super.initState();

    context.read<ChatViewModel>()
        .fetch();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ChatViewModel>();
    final loginViewModel = context.watch<LoginViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        actions: [
          IconButton(
              onPressed: () {
                context.read<LoginViewModel>().logout();
              },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: viewModel.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: viewModel.chatList.length,
                      itemBuilder: (context, index) {
                        Chat chat = viewModel.chatList[index];
                        if (loginViewModel.user!.email ==
                            chat.email) {
                          return MyChatItem(chat: chat);
                        } else {
                          return OtherChatItem(chat: chat);
                        }
                      },
                    ),
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
                        await viewModel.pushMessage(_controller.text, loginViewModel.user!);

                        // 입력 창 초기화
                        _controller.clear();
                        // 스크롤 끝으로 이동
                        _scrollToBottom();
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

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
