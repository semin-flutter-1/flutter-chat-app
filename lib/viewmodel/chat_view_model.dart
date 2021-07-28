import 'package:chat_app/model/chat.dart';
import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/repository/firebase/firestore_chat_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ChatViewModel extends ChangeNotifier {
  final FirestoreChatRepository _repository;

  ChatViewModel(this._repository);

  List<Chat> _chatList = [];

  List<Chat> get chatList => _chatList;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> fetch() async {
    _isLoading = true;
    _chatList = await _repository.getAll();
    _isLoading = false;
    notifyListeners();
  }

  Stream<QuerySnapshot<Chat>> getChatListStream() {
    return _repository.getChatRef();
  }

  Future<void> pushMessage(String text, ChatUser user) async {
    await _repository.add(Chat(
      user.name,
      user.profileUrl,
      text,
      DateTime.now().millisecondsSinceEpoch,
      user.email,
    ));
    _chatList = await _repository.getAll();
    notifyListeners();
  }
}
