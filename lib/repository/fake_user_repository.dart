import 'package:chat_app/model/user.dart';
import 'package:chat_app/repository/user_repository.dart';

class FakeUserRepository extends UserRepository {
  User? _user;
  User? get user => _user;

  @override
  Future login() async {
    await Future.delayed(Duration(seconds: 1));
    _user = User('bbb@aaa.com', '', '오준석');
  }

  @override
  void logout() {
    _user = null;
  }

}