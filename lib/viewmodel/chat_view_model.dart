import 'package:chat_app/model/chat.dart';
import 'package:chat_app/repository/repository.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:flutter/foundation.dart';

class ChatViewModel extends ChangeNotifier {
  final Repository<Chat> repository;
  final UserRepository userRepository;

  ChatViewModel(this.repository, this.userRepository);

  List<Chat> _chatList = [];

  List<Chat> get chatList => _chatList;

  bool _isLoading = false;

  get isLoading => _isLoading;

  Future<void> fetch() async {
    _isLoading = true;
    _chatList = await repository.getAll();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> pushMessage(String text) async {
    await repository.add(Chat(
      userRepository.user!.name,
      userRepository.user!.profileUrl,
      text,
      DateTime.now().millisecondsSinceEpoch,
      userRepository.user!.email,
    ));
    _chatList = await repository.getAll();
    notifyListeners();
  }
}
