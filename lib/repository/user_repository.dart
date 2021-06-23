import 'package:chat_app/model/user.dart';

abstract class UserRepository {
  Future<void> login();

  void logout();

  User? get user;
}