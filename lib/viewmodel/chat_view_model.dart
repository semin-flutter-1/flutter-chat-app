import 'package:chat_app/model/chat.dart';
import 'package:chat_app/repository/repository.dart';
import 'package:flutter/foundation.dart';

class ChatViewModel extends ChangeNotifier {
  final Repository<Chat> repository;

  ChatViewModel(this.repository);

  List<Chat> _chatList = [];

  List<Chat> get chatList => _chatList;

  bool _isLoading = false;

  get isLoading => _isLoading;

  void fetch() {
    _isLoading = true;
    repository.getAll().then((value) {
      _chatList = value;
      _isLoading = false;
      notifyListeners();
    });
  }

  void pushMessage(String email, String text) {
    repository
        .add(Chat(
      '오준석',
      'https://yt3.ggpht.com/ytc/AAUvwniqTHfAb4NIjTwa5_G1BQmABidGaQ5SZc3AzOQF=s900-c-k-c0x00ffffff-no-rj',
      text,
      DateTime.now().millisecondsSinceEpoch,
      email,
    ))
        .whenComplete(() {
      notifyListeners();
    });
  }
}
