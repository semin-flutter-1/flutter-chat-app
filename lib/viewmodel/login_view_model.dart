import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:flutter/foundation.dart';

class LoginViewModel extends ChangeNotifier {
  UserRepository repository;
  bool isLogin = false;

  LoginViewModel(this.repository) {
    repository.authStateChanges().listen((ChatUser? user) {
      if (user == null) {
        isLogin = false;
      } else {
        isLogin = true;
      }
      notifyListeners();
    });
  }

  void login() {
    repository.login();
  }

  void logout() {
    repository.logout();
  }
}
