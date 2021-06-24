import 'dart:async';

import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/repository/user_repository.dart';

class FakeUserRepository extends UserRepository {
  ChatUser? _user;

  ChatUser? get user => _user;

  StreamController<ChatUser?> _authStateStreamController = StreamController();

  @override
  Future<ChatUser?> login() async {
    await Future.delayed(Duration(seconds: 1));
    _user = ChatUser('bbb@aaa.com', '', '오준석');
    _authStateStreamController.add(_user);
    return _user;
  }

  @override
  Future logout() async {
    _authStateStreamController.add(null);
    _user = null;
  }

  @override
  Stream<ChatUser?> authStateChanges() {
    return _authStateStreamController.stream;
  }
}
