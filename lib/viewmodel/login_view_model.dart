import 'package:chat_app/repository/user_repository.dart';
import 'package:flutter/foundation.dart';

class LoginViewModel extends ChangeNotifier {
  UserRepository repository;

  LoginViewModel(this.repository);

  get isLogin => repository.user != null;

  void login() {
    repository.login().whenComplete(() {
      notifyListeners();
    });
  }

  void logout() {
    repository.logout();
    notifyListeners();
  }
}
