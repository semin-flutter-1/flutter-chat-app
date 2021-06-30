import 'package:chat_app/model/chat_user.dart';
import 'package:chat_app/model/result.dart';
import 'package:chat_app/repository/user_repository.dart';
import 'package:get/get.dart';

class LoginViewModel extends GetxController {
  UserRepository repository;

  ChatUser? user;

  LoginViewModel(this.repository) {
    repository.authStateChanges().listen((Result<ChatUser> result) {
      if (result is Success<ChatUser>) {
        user = result.data;
      } else if (result is Error<ChatUser>) {
        user = null;
        print(result.e);
      }
      update();
    });
  }

  void login() {
    repository.login();
  }

  void logout() {
    repository.logout();
  }
}
