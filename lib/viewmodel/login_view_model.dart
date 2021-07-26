import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/model/result.dart';
import 'package:chat_app/repository/firebase/firebase_user_repository.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:flutter/foundation.dart';

class LoginViewModel extends ChangeNotifier {
  UserRepository _repository;

  ChatUser? user;

  LoginViewModel({UserRepository? userRepository})
      : _repository = userRepository ?? FirebaseUserRepository() {
    _repository.authStateChanges().listen((Result<ChatUser> result) {
      if (result is Success<ChatUser>) {
        user = result.data;
      } else if (result is Error<ChatUser>) {
        user = null;
        print(result.e);
      }
      notifyListeners();
    });
  }

  Future<ChatUser?> login() async {
    return await _repository.login();
  }

  Future<void> logout() async {
    await _repository.logout();
  }
}
