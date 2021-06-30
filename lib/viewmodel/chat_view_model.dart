import 'package:chat_app/model/chat.dart';
import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/repository/repository.dart';
import 'package:get/get.dart';

class ChatViewModel extends GetxController {
  final Repository<Chat> repository;

  ChatViewModel(this.repository);

  List<Chat> _chatList = [];

  List<Chat> get chatList => _chatList;

  bool _isLoading = false;

  get isLoading => _isLoading;

  Future<void> fetch() async {
    _isLoading = true;
    _chatList = await repository.getAll();
    _isLoading = false;
    update();
  }

  Future<void> pushMessage(String text, ChatUser user) async {
    await repository.add(Chat(
      user.name,
      user.profileUrl,
      text,
      DateTime.now().millisecondsSinceEpoch,
      user.email,
    ));
    _chatList = await repository.getAll();
    update();
  }
}
